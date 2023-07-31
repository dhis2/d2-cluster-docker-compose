#!/bin/sh

PROJECT_NAME="$(basename $PN)"


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
        docker exec ${PROJECT_NAME}_db_1 rm /var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP

fi
