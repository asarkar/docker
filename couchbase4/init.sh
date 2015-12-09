#!/bin/bash

isRunning() {
	echo "$($CB_HOME/etc/couchbase_init.d status)" | grep not > /dev/null 2>&1

	return "$?"
}

rm -f /etc/init.d/couchbase-server
$CB_HOME/etc/couchbase_init.d restart > /dev/null 2>&1

DEFAULT_NUM_RETRY=5
DEFAULT_RETRY_INTERVAL=2

NUM_RETRY=${NUM_RETRY:-$(echo $DEFAULT_NUM_RETRY)}
RETRY_INTERVAL=${RETRY_INTERVAL:-$(echo $DEFAULT_RETRY_INTERVAL)}

COUNTER=$NUM_RETRY

isRunning
while [ "$?" -eq 0 -a $COUNTER -gt 0 ]; do
    COUNTER=$((COUNTER - 1))

    sleep $RETRY_INTERVAL
done

isRunning
if [ "$?" -eq 0 ]; then
    printf "[ERROR] Failed to start Couchbase server after %d seconds.\n" $((NUM_RETRY * RETRY_INTERVAL))

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

ENDPOINT=http://127.0.0.1:8091

printf "\n[INFO] Setting up admin credentials.\n"
curl -sSL -w "%{http_code} %{url_effective}\\n" -d username=$CB_USERNAME -d password=$CB_PASSWORD -d port=8091 $ENDPOINT/settings/web

printf "\n[INFO] Configuring memory quota.\n"
curl -sSL -w "%{http_code} %{url_effective}\\n" -u $CB_USERNAME:$CB_PASSWORD -d memoryQuota=256 -d indexMemoryQuota=256 $ENDPOINT/pools/default

# if [ -n "$SAMPLE_BUCKETS" ]; then
#	IFS=',' read -ra BUCKETS <<< "$SAMPLE_BUCKETS"

#	for bucket in "${BUCKETS[@]}"; do
#		printf "\n[INFO] Installing %s.\n" "$bucket"
#		curl -sSL -w "%{http_code} %{url_effective}\\n" -u $CB_USERNAME:$CB_PASSWORD --data-ascii '["'"$bucket"'"]' $ENDPOINT/sampleBuckets/install
#	done
# fi

supervisord -c /etc/supervisord.conf





