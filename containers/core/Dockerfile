# Build the DHIS2 Core server from source
FROM maven:3.5.4-jdk-8-slim as build
#NB - maven-frontend-plugin breaks on Alpine linux

RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*
ADD ./src /dhis2/src

RUN cd /dhis2/src/dhis-2 && mvn clean install -Pdev -T1C
RUN cd /dhis2/src/dhis-2/dhis-web && mvn clean install -Pdev -T1C

# Serve the packaged .war file
FROM tomcat:8.5.34-jre8-alpine as serve

COPY --from=build /dhis2/src/dhis-2/dhis-web/dhis-web-portal/target/dhis.war /usr/local/tomcat/webapps/ROOT.war
ENV DHIS2_HOME=/DHIS2_home

# Specify the DHIS2 version to download, i.e. '2.30' or 'dev' (the latest build)
# ARG VERSION=dev
# RUN apk add --no-cache curl && \
#     rm -rf /usr/local/tomcat/webapps/* && \
#     echo "Downloading WAR version ${VERSION}" && \
#     curl -SL -o /usr/local/tomcat/webapps/ROOT.war https://s3-eu-west-1.amazonaws.com/releases.dhis2.org/${VERSION}/dhis.war