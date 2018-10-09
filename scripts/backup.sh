#!/bin/bash
set -e

waitTime=5
dbContainer=db
dbName=dhis2
dbUser=dhis
dbPass=dhis

if [ $# -eq 0 ]
  then
    echo "USAGE: scripts/backup.sh <path/to/backupfile.sql.gz> [full]" 1>&2
    exit 1
fi

file="$1"
if [ -f $file ]
  then
    echo "ERROR: The file '$file' already exists." 1>&2
    exit 1
fi

started=0
if [ ${file: -7} == ".sql.gz" ]
  then
    upcount=`docker-compose ps db | grep Up | wc -l`
    if [ $upcount -eq 0 ]
      then
        echo "Starting db container..."
        docker-compose up -d db
        
        echo "Waiting $waitTime seconds for postgres initialization..."
        sleep $waitTime

        started=1
    fi
    
    echo "Backing up to '$file'..."
    if [ "$2" == "full" ]
      then
        docker-compose exec -e PGPASSWORD=$dbPass -T $dbContainer pg_dump --clean --if-exists -h $dbContainer --dbname $dbName --username $dbUser | gzip -c > $file
      else # Exclude analytics and resource tables
        docker-compose exec -e PGPASSWORD=$dbPass -T $dbContainer pg_dump --clean --if-exists -T analytics* -T _* -h $dbContainer --dbname $dbName --username $dbUser | gzip -c > $file
    fi
    
    if [ $started -eq 1 ]
      then
        echo "Stopping db container..."
        docker-compose stop db
    fi

    exit 0
  else
    echo "ERROR: Unrecognized file extension, '.sql' or '.sql.gz' expected." 1>&2
    exit 1
fi