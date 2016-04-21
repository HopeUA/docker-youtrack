#!/bin/sh

#########################################################
# Convert env variables to Java options
#########################################################
function config_app() {
  local opts=""

  # Add java options
  opts+="-Xmx${JAVA_mx} "

  JAVA_headless=${JAVA_headless:="true"}
  if [ ${JAVA_headless} == "true" ]; then
    opts+="-Djava.awt.headless=true "
  fi

  # Add Youtrack options
  for i in $( set -o posix ; set | grep ^YT_ | sort -rn ); do
    local param=$(echo ${i} | awk -F'=' '{print $1}' | sed 's/YT_//g' | sed 's/_/\./g')
    local val=$(echo ${i} | awk -F'=' '{print $2}')
    if [ -n ${val} ]; then
      opts+="-D${param}=${val} "
    fi
  done

  echo ${opts}
}
