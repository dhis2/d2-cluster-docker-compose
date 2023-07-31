#!/bin/bash

# move the config files to the data directory
cp /var/lib/postgresql/pg_hba.conf /var/lib/postgresql/data/ -f
cp /var/lib/postgresql/postgresql.conf /var/lib/postgresql/data/ -f