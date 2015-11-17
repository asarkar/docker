FROM centos:latest
MAINTAINER "Abhijit Sarkar" "https://github.com/abhijitsarkar"

RUN yum -y -q update; \
yum -y -q clean all;

# install system tools
RUN yum -y install wget; \
yum -y install python-setuptools; \
easy_install supervisor; \
yum -y install patch

ADD ./supervisord.conf /etc/supervisord.conf

# install java
RUN wget -P /opt -nv --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm"; \
rpm -ih /opt/jdk-8u66-linux-x64.rpm; \
rm -f /opt/jdk-8u66-linux-x64.rpm

# install tomcat
RUN wget -nv -O- http://www.us.apache.org/dist/tomcat/tomcat-8/v8.0.28/bin/apache-tomcat-8.0.28.tar.gz | tar xz -C /opt; \
find /opt/apache-tomcat-8.0.28/bin -type f -name "*.bat" -exec rm -f {} +; \
ln -sf /opt/apache-tomcat-8.0.28 /opt/tomcat

ENV CATALINA_HOME /opt/tomcat

ADD ./tomcat-users.xml.patch /tmp/tomcat-users.xml.patch

RUN patch -d $CATALINA_HOME/conf -p0 -u < /tmp/tomcat-users.xml.patch; \
rm -f /tmp/tomcat-users.xml.patch

RUN groupadd dev; \
useradd -g dev -s /usr/bin/bash tomcat; \
chown -RL tomcat:dev $CATALINA_HOME

ENV JAVA_HOME /usr/java/default

# only a hint. still need -P at runtime
EXPOSE 8080

CMD ["supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
