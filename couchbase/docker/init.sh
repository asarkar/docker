#!/bin/bash

# Monitor mode - enables job control
set -m

chown -R couchbase:couchbase /opt/couchbase/var
/entrypoint.sh couchbase-server &

NUM_RETRY=${CB_WAIT_NB_TRY:-30}
RETRY_INTERVAL=${CB_WAIT_INTERVAL:-10}

printf "Waiting for port 8091 to be open\n"
/usr/sbin/wait.sh -n ${NUM_RETRY} -i ${RETRY_INTERVAL} 127.0.0.1:8091

couchbase-cli server-list \
  --cluster=couchbase:8091 \
  --user=$ADMIN_USER \
  --password=$ADMIN_PASSWORD | grep -v -i error > /dev/null 2>&1

if [ $? -eq 0 ] ; then
  printf "Existing installation found, skipping initialization\n"
else
  /usr/sbin/init-node.sh
  /usr/sbin/init-cluster.sh
fi;

/usr/sbin/cluster-status.sh

fg 1
