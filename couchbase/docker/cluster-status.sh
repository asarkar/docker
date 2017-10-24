#!/bin/bash

set -m

printf "*****************************************************************\n"
printf "* Cluster status via service $SERVICENAME:8091                 *\n"
printf "*****************************************************************\n"
printf "Server list:\n"
couchbase-cli server-list \
  --cluster=$SERVICENAME:8091 \
  --user=$ADMIN_USER \
  --password=$ADMIN_PASSWORD

printf "Bucket list:\n"
couchbase-cli bucket-list \
  --cluster=$SERVICENAME:8091 \
  --user=$ADMIN_USER \
  --password=$ADMIN_PASSWORD
