#!/bin/bash

set -e

POD_HOSTNAME="${HOSTNAME}.${SERVICENAME}"

printf "Initializing Couchbase node\n"
couchbase-cli node-init --cluster=127.0.0.1:8091 \
  --user=$ADMIN_USER \
  --password=$ADMIN_PASSWORD \
  --node-init-hostname=$POD_HOSTNAME
