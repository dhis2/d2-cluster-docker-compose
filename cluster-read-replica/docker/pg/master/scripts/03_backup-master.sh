#!/bin/bash

# check if the file "/var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP" exists
if [ -f /var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP ]; then
    echo "Backup already exists"
    exit 0
else
    pg_basebackup -D /var/lib/postgresql/data-rr/dhis2-rr/ -S replication_slot_rr1 -X stream -P -U replicator -Fp -R
    echo "completed" > /var/lib/postgresql/data-rr/dhis2-rr/PG_RR_BACKUP
fi
