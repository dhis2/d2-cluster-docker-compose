# DHIS2 Dockerized Server

## Pre-requisites

* [Docker Desktop](https://www.docker.com/products/docker-desktop) (Mac or Windows) or [Docker Engine](https://docs.docker.com/install/#supported-platforms) on Linux
* [Docker Compose](https://docs.docker.com/compose/install/) (included with **Docker Desktop** on Mac and Windows)


## Basic Usage

Launch all frontends by using the below command
```bash
> docker-compose up
```

Individual frontends can be launched by starting the proxy server and one or more services
```bash
> docker-compose up proxy [app-name ...]
```
