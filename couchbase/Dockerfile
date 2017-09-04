FROM asarkar/debian-supervisor:jessie

ENV CB_HOME=/opt/couchbase INIT_SCRIPT=/usr/sbin/init.sh
ENV PATH=$PATH:/opt/couchbase/bin:/opt/couchbase/bin/tools:/opt/couchbase/bin/install

# https://developer.couchbase.com/documentation/server/current/install/ubuntu-debian-install.html
RUN apt-get update && \
  apt-get install -y curl lsb-release && \
	curl -sSL -O 'http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-3-amd64.deb' && \
	find * -maxdepth 0 -name "couchbase*.deb" -type f -exec dpkg -i {} + && \
	apt-get update && apt-get install -y --force-yes couchbase-server && \
	apt-get autoremove && apt-get clean && \
	rm -rf "couchbase*.deb" /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR $CB_HOME/var/lib

RUN export CB_VERSION=`cat $CB_HOME/VERSION.txt`

EXPOSE 8091 8092 8093 8094 11207 11210 11211 18091 18092 18093
VOLUME $CB_HOME/var

ADD ./couchbased.conf /etc/supervisor/conf.d/
ADD ./init.sh $INIT_SCRIPT

RUN chmod +x $INIT_SCRIPT

ENTRYPOINT ["/usr/sbin/init.sh"]
