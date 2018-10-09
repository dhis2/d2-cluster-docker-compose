FROM tomcat:8.5.34-jre8-alpine

# Specify the DHIS2 version to download, i.e. '2.30' or 'dev' (the latest build)
# TODO support previous builds of each version
ARG VERSION=dev
ENV DHIS2_HOME=/DHIS2_home
RUN apk add --no-cache curl && \
    rm -rf /usr/local/tomcat/webapps/* && \
    echo "Downloading WAR version ${VERSION}" && \
    curl -SL -o /usr/local/tomcat/webapps/ROOT.war https://s3-eu-west-1.amazonaws.com/releases.dhis2.org/${VERSION}/dhis.war