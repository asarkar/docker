#!/bin/bash

set -m

DEFAULT_NUM_RETRIES=5
DEFAULT_RETRY_INTERVAL=5

usage() {
    cat << END
Usage: $0 [OPTIONS] DEP_ADDR1:DEP_PORT1[,...,DEP_ADDRn:DEP_PORTn]

This script waits for a given number of dependencies to come online.

OPTIONS:
  -h      Show this message.
  -n      Number of attempts. Optional. Defaults to $DEFAULT_NUM_RETRIES.
  -i      Interval between the attempts. Optional. Defaults to $DEFAULT_RETRY_INTERVAL.
END
}

while getopts ":n::i::h" opt; do
  case ${opt} in
    n) NUM_RETRIES=$OPTARG;;
    i) RETRY_INTERVAL=$OPTARG;;
    h) usage 0;;
    \?) echo "Unknown option: -$OPTARG" >&2; usage; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; usage; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; usage; exit 1;;
  esac
done

shift $((OPTIND - 1))

NUM_RETRIES=${NUM_RETRIES:-$(echo $DEFAULT_NUM_RETRIES)}
RETRY_INTERVAL=${RETRY_INTERVAL:-$(echo $DEFAULT_RETRY_INTERVAL)}
DEPENDENCIES=$(echo "$@" | sed -e 's/\s\+//g')

if [ -z "$DEPENDENCIES" ]; then
    usage; exit 1
fi

IFS=',' read -a LIST <<< "$DEPENDENCIES"

for DEPENDENCY in "${LIST[@]}"; do
  DEPENDENCY=$(echo "$DEPENDENCY" | sed -e 's/\s\+//g')
  IFS=':' read -a DEP <<< "$DEPENDENCY"
  LEN=${#DEP[@]}

  if ((LEN < 2)); then
    usage; exit 1
  fi

  DEP_ADDR=${DEP[0]}
  DEP_PORT=${DEP[1]}

  if [ -z $DEP_ADDR ] || [ -z $DEP_PORT ]; then
    usage; exit 1
  fi

  nc -w5 -z $DEP_ADDR $DEP_PORT

  STATUS=$?

  COUNTER=$NUM_RETRIES

  while ((COUNTER > 0)) && ((STATUS > 0)); do
      printf "Retrying connection to dependency (%s:%d)\n" $DEP_ADDR $DEP_PORT
      nc -w5 -z $DEP_ADDR $DEP_PORT > /dev/null 2>&1

      STATUS=$?
      ((COUNTER--))

      sleep $RETRY_INTERVAL
  done

  if ((STATUS > 0)); then
      printf "Failed to connect to dependency (%s:%d) after %d seconds\n" $DEP_ADDR $DEP_PORT "$((NUM_RETRIES * RETRY_INTERVAL))"

      exit 1
  else
      printf "Connection to dependency (%s:%d) is successful\n" $DEP_ADDR $DEP_PORT
  fi
done
