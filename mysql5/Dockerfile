FROM abhijitsarkar/debian:supervisor

ENV DEBIAN_FRONTEND noninteractive
ENV DATADIR /var/lib/mysql

RUN apt-get update && \
	apt-get upgrade -y

RUN getent group dev || groupadd dev && \
	useradd -g dev mysql

# install mysql and delete preconfigured database
RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections && \
	echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections && \
	apt-get install -y mysql-server && \
	chown -RL mysql:dev $DATADIR && \
	mysql_install_db --datadir=$DATADIR

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf && \
	echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && \
	c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf && \
	mv /tmp/my.cnf /etc/mysql/my.cnf

ADD ./mysqld.conf /etc/supervisor/conf.d

VOLUME $DATADIR

EXPOSE 3306

CMD ["supervisord", "-c", "/etc/supervisord.conf"]