### Useful REST API Calls

##### Delete Bucket
`curl -u USERNAME:PASSWORD -X DELETE http://HOSTNAME:8091/pools/default/buckets/BUCKET NAME`

##### Get Bucket Info
`curl http://HOSTNAME:8091/pools/default/buckets/BUCKET NAME`

##### Install travel-sample Bucket
`curl -sSL -w "%{http_code} %{url_effective}\\n" -u admin:admin123 --data-ascii '["travel-sample"]' http://HOSTNAME:8091/sampleBuckets/install`

##### Drop index
`DROP INDEX `travel-sample`.`def_airportname` USING GSI`
