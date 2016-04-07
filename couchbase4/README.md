### Useful REST API Calls

##### Delete Bucket
`curl -u <ADMIN>:<PASSWORD> -X DELETE http://<HOSTNAME>:<PORT>/pools/default/buckets/<BUCKET NAME>`

##### Get Bucket Info
`curl http://<HOSTNAME>:<PORT>/pools/default/buckets/<BUCKET NAME>`

##### Install travel-sample Bucket
`curl -sSL -w "%{http_code} %{url_effective}\\n" -u <ADMIN>:<PASSWORD> --data-ascii '["travel-sample"]' http://<HOSTNAME>:<PORT>/sampleBuckets/install`

##### Drop index
```
DROP INDEX `travel-sample`.`def_airportname` USING GSI
```

##### Allocate RAM to a node
`curl -X POST -u <ADMIN>:<PASSWORD> -d memoryQuota=<VALUE> http://<HOSTNAME>:<PORT>/pools/default`

##### Allocate RAM to a bucket
`curl -X POST -u <ADMIN>:<PASSWORD> -d ramQuotaMB=<VALUE> http://<HOSTNAME>:<PORT>/pools/default/buckets/<BUCKET NAME>`

### References:

[Setting memory quota](http://docs.couchbase.com/admin/admin/REST/rest-node-memory-quota.html)

[Cluster and Bucket RAM quotas](http://developer.couchbase.com/documentation/server/4.0/architecture/cluster-ram-quotas.html)

[Changing bucket memory quota](http://developer.couchbase.com/documentation/server/4.1/rest-api/rest-bucket-memory-quota.html)

