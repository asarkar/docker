FROM abhijitsarkar/docker:debian-supervisor

ENV DEBIAN_FRONTEND=noninteractive DATADIR=/var/lib/mysql INIT_SCRIPT=/usr/sbin/init.sh

RUN apt-get update && \
  apt-get -y install lsb-release

RUN getent group dev || groupadd dev && \
	useradd -g dev mysql

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5 && \
	echo "deb http://repo.mysql.com/apt/debian/ $(lsb_release -sc) mysql-5.7" > /etc/apt/sources.list.d/mysql.list && \
	apt-get update && \
	apt-get install -y patch

# install mysql and delete preconfigured database
RUN echo "mysql-community-server mysql-community-server/root-pass password ''" | debconf-set-selections && \
	echo "mysql-community-server mysql-community-server/re-root-pass password ''" | debconf-set-selections && \
	apt-get install -y mysql-server-5.7 && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf $DATADIR && \
	mkdir -p $DATADIR && \
	mysqld --initialize-insecure=on --datadir=$DATADIR && \
	chown -RL mysql:dev $DATADIR

ADD ./my.cnf.patch /tmp/my.cnf.patch

RUN patch -d /etc/mysql -p0 -u < /tmp/my.cnf.patch && \
	rm -f /tmp/my.cnf.patch

ADD ./world.sql /usr/local/share/mysql/world.sql
ADD ./init.sh $INIT_SCRIPT

CMD ["/usr/local/share/mysql/world.sql"]

RUN chmod +x $INIT_SCRIPT

VOLUME $DATADIR

EXPOSE 3306

ADD ./mysqld.conf /etc/supervisor/conf.d

ENTRYPOINT ["/usr/sbin/init.sh"]