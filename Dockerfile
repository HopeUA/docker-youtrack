FROM hope/java:8

MAINTAINER Sergey Sadovoi <sergey@hope.ua>

ENV \
    # https://www.jetbrains.com/youtrack/download/get_youtrack.html
    YOUTRACK_VERSION=7.0 \
    YOUTRACK_BUILD=27777 \
    YOUTRACK_PORT=8080 \
    YOUTRACK_INSTALL=/usr/local/youtrack

RUN \
    apk add --no-cache --virtual=build-dependencies wget ca-certificates && \
    cd "/tmp" && \

    # Youtrack install
    wget https://download.jetbrains.com/charisma/youtrack-${YOUTRACK_VERSION}.${YOUTRACK_BUILD}.zip && \

    unzip youtrack-${YOUTRACK_VERSION}.${YOUTRACK_BUILD}.zip && \
    rm -rf youtrack-${YOUTRACK_BUILD}/internal/java && \
    mv youtrack-${YOUTRACK_BUILD} ${YOUTRACK_INSTALL} && \

    # Cleanup
    apk del build-dependencies && \
    rm "/tmp/"*

VOLUME /data

EXPOSE ${YOUTRACK_PORT}

ENTRYPOINT ["/usr/local/youtrack/bin/youtrack.sh"]
CMD ["run", "--no-browser"]
