FROM abhijitsarkar/docker:jdk8

ENV CATALINA_HOME=/opt/tomcat TOMCAT_VERSION=8.0.28 HTTP_PORT=${HTTP_PORT:-8080} DEBUG_PORT=${DEBUG_PORT:-8000} SHUTDOWN_PORT=${SHUTDOWN_PORT:-8005} SUSPEND_ON_DEBUG=${SUSPEND_ON_DEBUG:-n}

RUN apt-get update && \
  apt-get install -y patch netcat

WORKDIR /opt

RUN getent group dev || groupadd dev && \
	useradd -M -g dev tomcat

RUN curl -sSL http://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz | tar xz && \
	find apache-tomcat-$TOMCAT_VERSION/bin -type f -name "*.bat" -exec rm -f {} + && \
	ln -sf apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

ADD ./tomcatd.conf /etc/supervisor/conf.d/

ADD ./tomcat-users.xml.patch /tmp/tomcat/tomcat-users.xml.patch
ADD ./server.xml.patch /tmp/tomcat/server.xml.patch

ADD ./setenv.sh $CATALINA_HOME/bin/

WORKDIR $CATALINA_HOME

RUN patch -d conf -p0 -u < /tmp/tomcat/tomcat-users.xml.patch && \
	patch -d conf -p0 -u < /tmp/tomcat/server.xml.patch && \
	rm -rf /tmp/tomcat && \
	rm -rf webapps/examples webapps/docs webapps/ROOT

RUN chown -RL tomcat:dev $CATALINA_HOME

EXPOSE ${HTTP_PORT} ${DEBUG_PORT} ${SHUTDOWN_PORT}

VOLUME $CATALINA_HOME

CMD ["supervisord", "-c", "/etc/supervisord.conf"]