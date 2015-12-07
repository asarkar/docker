FROM abhijitsarkar/docker:debian-supervisor

ENV CB_HOME=/opt/couchbase INIT_SCRIPT=/usr/sbin/init.sh COUCHBASE_PKG=couchbase-server-community_4.0.0-debian7_amd64.deb

RUN apt-get update && \
	getent group dev || groupadd dev && \
	useradd -M -u 1000 -g dev couchbase && \
	curl -sSL -O http://packages.couchbase.com/releases/4.0.0/$COUCHBASE_PKG && \
	dpkg -i $COUCHBASE_PKG && \
	rm -f $COUCHBASE_PKG

WORKDIR $CB_HOME/var/lib

RUN $CB_HOME/etc/couchbase_init.d stop && \
	rm -f /etc/init.d/couchbase-server && \
	mkdir -p moxi couchbase/config couchbase/data couchbase/stats couchbase/logs /var/log/couchbase \
	&& chown -R couchbase $CB_HOME/var

EXPOSE 8091 8092 8093 11207 11210 11211 18091 18092
VOLUME $CB_HOME/var

# ADD ./couchbased.conf /etc/supervisor/conf.d/
ADD ./init.sh $INIT_SCRIPT

RUN chmod +x $INIT_SCRIPT

ENTRYPOINT ["/usr/sbin/init.sh"]
