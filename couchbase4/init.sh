#!/bin/bash

$CB_HOME/etc/couchbase_init.d restart
sleep 5

echo "$($CB_HOME/etc/couchbase_init.d status)" | grep not > /dev/null 2>&1

if [ "$?" -eq 0 ]; then
	printf "\n[ERROR] Failed to start Couchbase server.\n"

	exit 1
fi

IFS=':' read -ra FIELDS <<< "$USER"

CB_USERNAME=${FIELDS[0]}
CB_PASSWORD=${FIELDS[1]}

DEFAULT_USERNAME=admin
DEFAULT_PASSWORD=admin123

if [ -z "$CB_USERNAME" ]; then
	printf "[WARN] Admin username not provided. Defaulting to '%s'.\n" "$DEFAULT_USERNAME"
fi
if [ -z "$CB_PASSWORD" ]; then
	printf "[WARN] Admin password not set. Defaulting to '%s'.\n" "$DEFAULT_PASSWORD"
fi

CB_USERNAME=${CB_USERNAME:-$(echo $DEFAULT_USERNAME)}
CB_PASSWORD=${CB_PASSWORD:-$(echo $DEFAULT_PASSWORD)}

ENDPOINT=http://localhost:8091

printf "\n[INFO] Setting up admin credentials...\n"
curl -d "username=$CB_USERNAME&password=$CB_PASSWORD&port=8091" $ENDPOINT/settings/web

printf "\n[INFO] Configuring memory quota...\n"
curl -u $CB_USERNAME:$CB_PASSWORD -d "memoryQuota=300&indexMemoryQuota=300" $ENDPOINT/pools/default

if [ "$TRAVEL_SAMPLE" == "true" ]; then
	printf "\n[INFO] Installing travel-sample...\n"
	curl -u $CB_USERNAME:$CB_PASSWORD -d '["travel-sample"]' $ENDPOINT/sampleBuckets/install
fi

tail -f /etc/hosts




