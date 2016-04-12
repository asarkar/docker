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

##### Get Bucket Info
`curl -u <USERNAME:PASSWORD> http://HOSTNAME:8091/pools/default/buckets/<BUCKET NAME>`

##### Flush Bucket
`curl -X POST -u <USERNAME:PASSWORD> http://<HOSTNAME:PORT>/pools/default/buckets/<BUCKET NAME>/controller/doFlush`

##### Install travel-sample Bucket
`curl -sSL -w "%{http_code} %{url_effective}\\n" -u <USERNAME:PASSWORD>  --data-ascii '["travel-sample"]' http://<HOSTNAME:PORT>/sampleBuckets/install`

##### Allocate RAM to a Bucket
`curl -X POST -u <ADMIN>:<PASSWORD> -d ramQuotaMB=<VALUE> http://<HOSTNAME>:<PORT>/pools/default/buckets/<BUCKET NAME>`

#### Miscellaneous

##### Drop Index
```
DROP INDEX `travel-sample`.`def_airportname` USING GSI
```
##### Get Cluster Info
`curl -u <ADMIN>:<PASSWORD> http://<HOSTNAME>:<PORT>/pools`

##### Allocate RAM to a Node
`curl -X POST -u <ADMIN>:<PASSWORD> -d memoryQuota=<VALUE> http://<HOSTNAME>:<PORT>/pools/default`


### Prerequisites for Volume Mapping
1. Comment out the `volumes` section in the docker-compose and run `docker-compose up -d`
2. Find out the container id using `docker ps -a`. Call it `<CONTAINER ID>`
3. `mkdir -p /opt/couchbase`
4. `docker cp <CONTAINER ID>:/opt/couchbase/var /opt/couchbase/var`
5. `chmod -R 777 /opt/couchbase`
6. `docker rm -f <CONTAINER ID>`
7. Uncomment `volumes` section and run `docker-compose up -d`

### Runtime Configurations

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


