#!/bin/sh

#########################################################
# Convert env variables to parameters string
#########################################################
function build_params() {
  local params=""

  # Add java options
  params+="-Xmx${JAVA_mx} "

  JAVA_headless=${JAVA_headless:="true"}
  if [ ${JAVA_headless} == "true" ]; then
    params+="-Djava.awt.headless=true "
  fi

  # Add Youtrack options
  for i in $( set -o posix ; set | grep ^APP_ | sort -rn ); do
    local param=$(echo ${i} | awk -F'=' '{print $1}' | sed 's/APP_//g' | sed 's/_/\./g')
    local val=$(echo ${i} | awk -F'=' '{print $2}')
    if [ -n ${val} ]; then
      params+="-D${param}=${val} "
    fi
  done

  echo ${params}
}
