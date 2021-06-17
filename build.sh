#!/bin/bash


# Process parameters
if [ $? -ne 0 ]
then
    echo ""
    done < "$0"
fi

_setArgs(){
  while [ "${1:-}" != "" ]; do
    case "$1" in
      "-c" | "--config_file")
        shift
        configFile=$1
        ;;
      "-f" | "--forceUpdate")
        forceUpdate=true
        ;;
      "-r" | "--forceRetry")
        forceRetry=true
        ;;
    esac
    shift
  done
}

# Remove old image

echo $configFile
echo $forceUpdate
echo $forceRetry


# if [[ "$(docker images -q myimage:mytag 2> /dev/null)" == "" ]]; then
#   # do something

# fi