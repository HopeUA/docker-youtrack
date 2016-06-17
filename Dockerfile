FROM hope/java:8

MAINTAINER Sergey Sadovoi <sergey@hope.ua>

ENV \
    # https://www.jetbrains.com/youtrack/download/get_youtrack.html
    YOUTRACK_VERSION=6.5.17105 \
    YOUTRACK_PORT=8080 \
    YOUTRACK_INSTALL=/usr/local/youtrack \
    JAVA_mx=1g \
    JAVA_headless=true \

    # Java start parameters (replace "." with "_")
    # https://confluence.jetbrains.com/display/YTD65/YouTrack+Start+Java+Parameters
    APP_jetbrains_youtrack_disableBrowser=true \
    APP_database_location=/data/app \
    APP_database_backup_location=/data/backup

COPY container-files/ /tmp/

RUN \
    apk add --no-cache --virtual=build-dependencies wget bash ca-certificates && \
    cd "/tmp" && \

    # Youtrack install
    wget https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar && \
    mkdir -p ${YOUTRACK_INSTALL} && \
    cp youtrack-${YOUTRACK_VERSION}.jar ${YOUTRACK_INSTALL} && \

    # Entrypoint
    cp -f /tmp/*.sh / && \
    chmod +x /run.sh && \

    # Cleanup
    apk del build-dependencies && \
    rm "/tmp/"*

VOLUME /data

EXPOSE ${YOUTRACK_PORT}

ENTRYPOINT ["/run.sh"]
