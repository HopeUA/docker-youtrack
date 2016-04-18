#!/bin/bash

set -e
set -u
source ./functions.sh

java_opts=$(config_app)
java \
  ${java_opts} \
  -jar /usr/local/youtrack/youtrack-${YOUTRACK_VERSION}.jar \
  ${YOUTRACK_PORT}
