# DHIS2 Dockerized Server

## Pre-requisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop) (Mac or Windows) or [Docker Engine](https://docs.docker.com/install/#supported-platforms) on Linux
* [Docker Compose](https://docs.docker.com/compose/install/) (included with **Docker Desktop** on Mac and Windows)
* A DHIS2 database `.sql` or `.sql.gz` file 

## Setup

First, build the containers for the DHIS2 Core instance and Postgres Database, then seed the database with some dummy data (**optional**):

```bash
> ./scripts/build.sh clean
> ./scripts/seed.sh <path/to/seedfile.sql.gz>
```

**Note** that once the server is up and running you will need to export Analytics Tables in the [Data Administration app](http://localhost:8080/dhis-web-data-administration/index.action#/analytics).  This must be run as a system user and can take some time to complete.

## Basic Usage

Once the containers have been built and the database seeded you can start the cluster:

```bash
> ./scripts/start.sh
```

_(it may take a couple minutes for the Java server to initialize)_

Once started, the services should automatically restart if Docker or the host machine are restarted.

You can stop the services manually:

```bash
> ./scripts/stop.sh
```

Or destroy the database data (which is stored in a Docker-managed [volume](https://docs.docker.com/storage/volumes/) on the host system):

```bash
> ./scripts/clean.sh
```

## Configuration and Logs

The `DHIS2_home` directory on the `core` container is mapped to the directory `./config/DHIS2_home`, so you can put configuration there as well as view DHIS2 system logs.  This directory is **NOT** deleted when running `clean.sh`.  The `dhis.conf` file is required to exist and by default has the following contents (note the database connection parameters):

```conf
connection.dialect = org.hibernate.dialect.PostgreSQLDialect
connection.driver_class = org.postgresql.Driver
connection.url = jdbc:postgresql://db/dhis2
connection.username = dhis
connection.password = dhis
# Database schema behavior, can be validate, update, create, create-drop
connection.schema = update

encryption.password = xxxx
metadata.audit.persist = on
```

## Accessing your new server

Once the container is running:

* Your DHIS2 instance will be accessible at [localhost:8080](http://localhost:8080/)
* You can access the postgres instance directly, if you want, at [localhost:5432](http://localhost:5432)