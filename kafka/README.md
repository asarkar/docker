Kafka image with topic deletion enabled.

### Build image
```
asarkar:~$ docker build -t asarkar/kafka --force-rm .
```

### Start Kafka with ZooKeeper
```
# 2181 is zookeeper, 9092 is kafka
asarkar:~$ docker run --name kafka -d -p 2181:2181 -p 9092:9092 \
--env ADVERTISED_HOST=127.0.0.1 --env ADVERTISED_PORT=9092 \
asarkar/kafka
```

### Kafka console
```
asarkar:~$ docker exec -it kafka bash
root@edc1411b7861:/# cd $KAFKA_HOME
```

### Show all topics
```
root@edc1411b7861:/opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh \
--zookeeper localhost:2181 \
--list
```

### Watch topic
```
root@edc1411b7861:/opt/kafka_2.11-0.10.1.0/bin/kafka-console-consumer.sh \
--bootstrap-server localhost:9092 \
--topic ufo --from-beginning
```

### Create topic
```
root@edc1411b7861:/opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh \
--zookeeper localhost:2181 \
--create --topic ufo --partitions 2 --replication-factor 1
```

### Delete topic
```
root@edc1411b7861:/opt/kafka_2.11-0.10.1.0/bin/kafka-topics.sh \
--zookeeper localhost:2181 \
--delete --topic ufo
```
