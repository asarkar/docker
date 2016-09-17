### Useful REST API Calls

#### Bucket Operations

##### Create Bucket

```
curl -v -X POST -u <USERNAME:PASSWORD> \
-d 'name=<BUCKET NAME>' -d 'ramQuotaMB=100' -d 'bucketType=couchbase' \
-d 'replicaNumber=0' -d 'replicaIndex=0' -d 'proxyPort=0' \
-d 'flushEnabled=1' \
-d 'authType=sasl' -d 'saslPassword=changeit' \
http://<HOSTNAME:PORT>/pools/default/buckets
```

##### Edit Bucket
> When editing bucket properties, be sure to specify all bucket properties.
> If a bucket property is not specified (whether or not you are changing the existing value),
> Couchbase Server may reset the property to the default.
> Even if you do not intend to change a certain property, re-specify the existing value to avoid this behavior.

```
curl -v -X POST -u <USERNAME:PASSWORD> \
-d 'ramQuotaMB=100' -d 'bucketType=couchbase' \
-d 'replicaNumber=0' -d 'replicaIndex=0' -d 'proxyPort=0' \
-d 'flushEnabled=1' \
-d 'authType=sasl' -d 'saslPassword=changeit' \
http://<HOSTNAME:PORT>/pools/default/buckets/<BUCKET NAME>
```

##### Delete Bucket
`curl -u <USERNAME:PASSWORD> -X DELETE http://<HOSTNAME:PORT>/pools/default/buckets/<BUCKET NAME>`

##### Get a Bucket Info
`curl -u <USERNAME:PASSWORD> http://HOSTNAME:8091/pools/default/buckets/<BUCKET NAME>`

##### Get All Bucket Info
`curl -u <ADMIN>:<PASSWORD> http://<HOSTNAME>:<PORT>/pools/default/buckets`

##### Flush Bucket
`curl -X POST -u <USERNAME:PASSWORD> http://<HOSTNAME:PORT>/pools/default/buckets/<BUCKET NAME>/controller/doFlush`

##### Install travel-sample Bucket
`curl -sSL -w "%{http_code} %{url_effective}\\n" -u <USERNAME:PASSWORD>  --data-ascii '["travel-sample"]' http://<HOSTNAME:PORT>/sampleBuckets/install`

##### Allocate RAM to a Bucket
`curl -X POST -u <ADMIN>:<PASSWORD> -d ramQuotaMB=<VALUE> http://<HOSTNAME>:<PORT>/pools/default/buckets/<BUCKET NAME>`

#### Cluster Operations

##### Add Node to Cluster
```
curl -u <ADMIN>:<PASSWORD> \
http://<HOSTNAME>:<PORT>/controller/addNode \
-d hostname=<HOST WHERE THE CLUSTER IS TO BE JOINED> \
-d user=<ADMIN> -d password=<PASSWORD> -d services=[kv|index|n1ql]
```

##### Rebalance Cluster (note that the node names need to be discovered by get cluster info call)
```
curl <ADMIN>:<PASSWORD> \
-d 'knownNodes=ns_1@<NODE 1 IP>,ns_1@<NODE 2 IP>' \
-d 'ejectedNodes=' \
-X POST http://<HOSTNAME>:<PORT>/controller/rebalance
```

##### Get Cluster Info
`curl -u <ADMIN>:<PASSWORD> http://<HOSTNAME>:<PORT>/pools/default`

##### Allocate RAM to a Node
`curl -X POST -u <ADMIN>:<PASSWORD> -d memoryQuota=<VALUE> http://<HOSTNAME>:<PORT>/pools/default`

#### Miscellaneous

##### Create Primary Index
1. Log onto the container.
2. Start Couchbase interactive query shell using `/opt/couchbase/bin/cbq`
3. `cbq> CREATE PRIMARY INDEX ON `travel-sample` USING GSI;`

##### Drop Index
1. Log onto the container.
2. Start Couchbase interactive query shell using `/opt/couchbase/bin/cbq`
3. `DROP INDEX `travel-sample`.`def_airportname` USING GSI;`

##### Query by key (port is usually 8093)

```
curl -u <BUCKET NAME>:<BUCKET PASSWORD> http://<HOSTNAME>:<PORT>/query/service \
-d 'statement=SELECT * FROM `<BUCKET NAME>` USE KEYS ["<KEY>"]'
```

### Prerequisites for Volume Mapping
1. Comment out the `volumes` section in the `docker-compose.yml` (Put a `#` in the beginning of the line)
2. Run `docker-compose up -d`
3. Find out the container id using `docker ps -a`. Call it \<CONTAINER ID\>
4. `mkdir -p /opt/couchbase`
5. `docker cp <CONTAINER ID>:/opt/couchbase/var /opt/couchbase/var`
6. `chmod -R 777 /opt/couchbase`
7. `docker rm -f <CONTAINER ID>`
8. Uncomment `volumes` section in the `docker-compose.yml`
9. Run `docker-compose up -d`
10. `curl -L http://localhost:8091`

### Runtime Options while Creating a Docker Container

##### Change admin credentials (default is `admin` / `admin123`)
Create the container with environment variable `USER`. Format is `<USERNAME:PASSWORD>`

##### Change Bucket RAM Quota (default is 300 MB)
Create the container with environment variable `MEMORY_QUOTA` (in MB)

##### Change Index RAM Quota (default is 300 MB)
Create the container with environment variable `INDEX_MEMORY_QUOTA` (in MB)

### References:

[Create or Edit Bucket](http://developer.couchbase.com/documentation/server/4.1/rest-api/rest-bucket-create.html)

[Changing bucket memory quota](http://developer.couchbase.com/documentation/server/4.1/rest-api/rest-bucket-memory-quota.html)

[Setting index memory quota](http://developer.couchbase.com/documentation/server/4.1/rest-api/rest-index-memory-quota.html)

[Cluster and Bucket RAM quotas](http://developer.couchbase.com/documentation/server/4.1/architecture/cluster-ram-quotas.html)

[Rebalancing nodes](http://developer.couchbase.com/documentation/server/4.1/rest-api/rest-cluster-rebalance.html)
