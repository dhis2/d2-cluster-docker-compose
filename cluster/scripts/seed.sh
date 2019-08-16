#!/bin/bash
set -e

waitTime=10
dbContainer=db
dbName=dhis2
dbUser=dhis
dbPass=dhis

[[ -z "$DOCKER_COMPOSE" ]] && DOCKER_COMPOSE="docker-compose"

if [ $# -eq 0 ]
  then
    echo "USAGE: scripts/seed.sh <path/to/seedfile.sql[.gz]>" 1>&2
    exit 1
fi

file="$1"
if [ ! -f $file ]
  then
    echo "ERROR: The file '$file' does not exist." 1>&2
    exit 1
fi

started=0
if [ ${file: -5} == ".dump" ] || ${file: -4} == ".sql" ] || [ ${file: -7} == ".sql.gz" ]
  then
    upcount=`$DOCKER_COMPOSE ps db | grep Up | wc -l`
    if [ $upcount -eq 0 ]
      then
        echo "Starting db container..."
        $DOCKER_COMPOSE up -d db

        echo "Waiting $waitTime seconds for postgres initialization..."
        sleep $waitTime

        started=1
    fi

    echo "Importing '$file'..."
    if [ ${file: -5} == ".dump" ] then
      cat $file | $DOCKER_COMPOSE exec -e PGPASSWORD=$dbPass -T $dbContainer pg_restore -h $dbContainer --dbname $dbName --username $dbUser
    elif [ ${file: -7} == ".sql.gz" ] then
      gunzip -c $file | $DOCKER_COMPOSE exec -e PGPASSWORD=$dbPass -T $dbContainer psql -h $dbContainer --dbname $dbName --username $dbUser
    else
      cat $file | $DOCKER_COMPOSE exec -e PGPASSWORD=$dbPass -T $dbContainer psql -h $dbContainer --dbname $dbName --username $dbUser
    fi

    if [ $started -eq 1 ]
      then
        echo "Stopping db container..."
        $DOCKER_COMPOSE stop db
    fi

    exit 0
  else
    echo "ERROR: Unrecognized file extension, '.sql' or '.sql.gz' expected." 1>&2
    exit 1
fi
