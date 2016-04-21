#!/bin/bash

set -e
set -u
source ./functions.sh

java_params=$(build_params)
java \
  ${java_params} \
  -jar /usr/local/youtrack/youtrack-${YOUTRACK_VERSION}.jar \
  ${YOUTRACK_PORT}
