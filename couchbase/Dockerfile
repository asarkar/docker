FROM abhijitsarkar/docker:debian-supervisor

ENV CB_HOME=/opt/couchbase CB_VERSION=4.1.0 INIT_SCRIPT=/usr/sbin/init.sh

RUN apt-get update && \
	getent group dev || groupadd dev && \
	useradd -M -u 1000 -g dev couchbase && \
	curl -sSL -O http://packages.couchbase.com/releases/$CB_VERSION/couchbase-server-enterprise_$CB_VERSION-debian7_amd64.deb && \
	find * -maxdepth 0 -name "couchbase*.deb" -type f -exec dpkg -i {} + && \
	rm -f "couchbase*.deb"

WORKDIR $CB_HOME/var/lib

RUN mkdir -p moxi couchbase/config couchbase/data couchbase/stats couchbase/logs \
	&& chown -R couchbase $CB_HOME/var

EXPOSE 8091 8092 8093 11207 11210 11211 18091 18092
VOLUME $CB_HOME/var

ADD ./couchbased.conf /etc/supervisor/conf.d/
ADD ./init.sh $INIT_SCRIPT

RUN chmod +x $INIT_SCRIPT

ENTRYPOINT ["/usr/sbin/init.sh"]
