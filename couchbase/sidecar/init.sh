#!/bin/bash

set -m

cacert="/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)"

numReady=$(curl -sS --cacert $cacert -H "Authorization: Bearer $token" \
 "https://kubernetes.default.svc/api/v1/namespaces/$POD_NAMESPACE/endpoints/$SERVICE" \
	| jq -r '.subsets[].addresses | length')

if (( numReady > 0 )); then
  printf "%s is ready\n" "$SERVICE"

  rand=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 8 | head -n 1)

  jq -r --arg name "$POD_NAME-$rand" \
   -f /etc/sidecar/sidecar.jq /etc/sidecar/sidecar.json | curl -sS --cacert $cacert \
   -H "Authorization: Bearer $token" \
   "https://kubernetes.default.svc/api/v1/namespaces/$POD_NAMESPACE/pods" \
   -X POST -H 'Content-Type: application/json' \
   --data @-
else
  printf "%s not ready\n" "$SERVICE"
fi

tail -f /dev/null
