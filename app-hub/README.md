# DHIS2 App Hub

## Pre-requisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop) (Mac or Windows) or [Docker Engine](https://docs.docker.com/install/#supported-platforms) on Linux
* [Docker Compose](https://docs.docker.com/compose/install/) (included with **Docker Desktop** on Mac and Windows)


## Basic Usage

To start the PostgreSQL server and App Hub backend/frontend you can start everything with a default database and some example data.

```bash
> ./scripts/start-and-seed.sh
```

Once started, the services should automatically restart if Docker or the host machine are restarted.

You can stop the services manually, this will also destroy the database as this is currently not in a separate volume:

```bash
> ./scripts/stop.sh
```

To seed the database on an existing cluster:

```bash
> ./scripts/seed.sh
```

To reset the database on an existing cluster:

```bash
> ./scripts/reset-db.sh
```

## Advanced Usage

To run the App Hub on a separate port than the default 8080, this is also possible. For example on port 8081:

```bash
> DHIS2_APPHUB_PORT=8081 ./scripts/start-and-seed.sh
```
