#!/bin/sh

PROJECT_NAME="$(basename $PN)"

# check if the file "/var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP" exists on the db container
# If it exists, then copy the backup to /data-rr on the host
# If it doesn't exist, then sleep for 30 seconds and try again
# retry 20 times
cnt=0
while [ $cnt -lt 20 ]; do
    if docker exec ${PROJECT_NAME}_db_1 test -f /var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP; then
        break
    fi
    echo "Backup not ready. Sleeping for 30 seconds... $1"
    sleep 30
    cnt=$((cnt+1))
done

if docker exec ${PROJECT_NAME}_db_1 test -f /var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP; then
    echo "Backup ready. Copying to /data-rr"
    # copy everything in the backup directory to /data-rr
    docker cp ${PROJECT_NAME}_db_1:/var/lib/postgresql/data-rr/dhis2-rr /data-rr
    # replace the postgresql.auto.conf file with the correct values    
    echo "primary_conninfo = 'host=db port=5432 user=replicator password=my_replicator_password'" > /data-rr/dhis2-rr/postgresql.auto.conf
    echo "primary_slot_name = 'replication_slot_rr1'" >> /data-rr/dhis2-rr/postgresql.auto.conf
    echo "Contents of /data-rr/dhis2-rr/postgresql.auto.conf:"
    cat /data-rr/dhis2-rr/postgresql.auto.conf
    cp -f /postgresql-rr.conf /data-rr/dhis2-rr/postgresql.conf
    ls -la /data-rr/dhis2-rr/
fi

