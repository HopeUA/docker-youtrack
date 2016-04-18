FROM hope/java:8

MAINTAINER Sergey Sadovoi <sergey@hope.ua>

ENV \
    YOUTRACK_VERSION=6.5.17057 \
    YOUTRACK_PORT=8080 \
    JAVA_mx=1g \
    JAVA_headless=true \

    # Java start parameters (replace "." with "_")
    # https://confluence.jetbrains.com/display/YTD65/YouTrack+Start+Java+Parameters
    YT_jetbrains_youtrack_disableBrowser=true \
    YT_database_location=/data/app \
    YT_database_backup_location=/data/backup

COPY container-files/ /tmp/

RUN \
    apk add --no-cache --virtual=build-dependencies wget bash ca-certificates && \
    cd "/tmp" && \

    # Youtrack install
    wget https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.jar && \
    mkdir -p /usr/local/youtrack && \
    cp youtrack-${YOUTRACK_VERSION}.jar /usr/local/youtrack && \

    # Entrypoint
    cp -f /tmp/*.sh / && \
    chmod +x /run.sh && \

    # Cleanup
    apk del build-dependencies && \
    rm "/tmp/"*

VOLUME /data

EXPOSE ${YOUTRACK_PORT}

ENTRYPOINT ["/run.sh"]
