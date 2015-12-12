FROM abhijitsarkar/docker:jdk8

ENV CATALINA_HOME=/opt/tomcat TOMCAT_VERSION=8.0.28 JPDA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"

RUN apt-get update && \
  apt-get install -y patch

WORKDIR /opt

RUN getent group dev || groupadd dev && \
	useradd -M -g dev tomcat

RUN curl -sSL http://archive.apache.org/dist/tomcat/tomcat-8/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz | tar xz && \
	find apache-tomcat-$TOMCAT_VERSION/bin -type f -name "*.bat" -exec rm -f {} + && \
	ln -sf apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME

ADD ./tomcatd.conf /etc/supervisor/conf.d/

ADD ./tomcat-users.xml.patch /tmp/tomcat-users.xml.patch

WORKDIR $CATALINA_HOME

RUN patch -d conf -p0 -u < /tmp/tomcat-users.xml.patch && \
	rm -f /tmp/tomcat-users.xml.patch && \
	rm -rf webapps/examples  webapps/docs  webapps/ROOT

RUN chown -RL tomcat:dev $CATALINA_HOME

VOLUME $CATALINA_HOME

EXPOSE 8000
EXPOSE 8080

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
