#!/bin/bash

set -e

printf "Initializing Couchbase cluster\n"
couchbase-cli cluster-init --cluster=127.0.0.1:8091 \
  --cluster-username=$ADMIN_USER \
  --cluster-password=$ADMIN_PASSWORD \
  --cluster-port=8091 \
  --cluster-ramsize=$DATA_MEMORY_QUOTA_MB \
  --cluster-index-ramsize=$INDEX_MEMORY_QUOTA_MB \
  --cluster-fts-ramsize=$SEARCH_MEMORY_QUOTA_MB \
  --index-storage-setting=memopt \
  --services=data,index,query
