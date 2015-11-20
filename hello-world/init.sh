#!/bin/bash

# https://docs.docker.com/v1.8/userguide/dockerlinks/
# https://docs.docker.com/compose/env/

# TODO: Figure out why verification doesn't work

nc -L5 -w5 -z -n $DB_PORT_3306_TCP_ADDR $DB_PORT_3306_TCP_PORT > /dev/null 2>&1

STATUS=$?

NUM_RETRY=5
RETRY_INTERVAL=5

while [ $NUM_RETRY -gt 0 -a $STATUS -gt 0 ]; do
    nc -L5 -w5 -z -n $DB_PORT_3306_TCP_ADDR $DB_PORT_3306_TCP_PORT > /dev/null 2>&1

    STATUS=$?
    NUM_RETRY=$((NUM_RETRY - 1))

    sleep $RETRY_INTERVAL
done

if [ $STATUS -gt 0 ]; then
    printf "[WARN] Failed to connect to the database.\n"

    # exit 1
else
     printf "[INFO] Database connection successful.\n"
fi

supervisord -c /etc/supervisord.conf