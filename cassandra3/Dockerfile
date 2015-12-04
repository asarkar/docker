FROM abhijitsarkar/docker:jdk8

ENV DEBIAN_FRONTEND=noninteractive CONF_DIR=/etc/cassandra CASSANDRA_HOME=/var/lib/cassandra LOG_DIR=/var/log/cassandra

RUN getent group dev || groupadd dev && \
	useradd -g dev cassandra && \
	echo "deb http://debian.datastax.com/community stable main" >> /etc/apt/sources.list.d/cassandra.sources.list && \
	curl -L https://debian.datastax.com/debian/repo_key | apt-key add -

RUN apt-get -y update && \
	apt-get -y install cassandra && \
	apt-get install -y patch && \
	rm -rf $CASSANDRA_HOMER/data/system/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -f /etc/init.d/cassandra && \
	chown -RL cassandra:dev $CONF_DIR && \
	chown -RL cassandra:dev $CASSANDRA_HOME && \
	chown -RL cassandra:dev $LOG_DIR

ADD *.patch /tmp/

RUN patch -d $CONF_DIR -p0 -u < /tmp/cassandra-env.sh.patch && \
	patch -d $CONF_DIR -p0 -u < /tmp/cassandra.yaml.patch && \
	rm -f /tmp/*.patch

ADD cassandrad.conf /etc/supervisor/conf.d

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

CMD ["supervisord", "-c", "/etc/supervisord.conf"]