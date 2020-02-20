FROM postgres:latest

RUN apt-get update && apt-get install -y postgresql-contrib

COPY createExtension.sh /docker-entrypoint-initdb.d/

RUN chmod 755 /docker-entrypoint-initdb.d/createExtension.sh
