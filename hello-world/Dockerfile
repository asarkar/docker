FROM abhijitsarkar/tomcat8

ENV INIT_SCRIPT /usr/bin/init.sh

RUN $CATALINA_HOME/bin/shutdown.sh > /dev/null 2>&1

ADD build/libs/*.war $CATALINA_HOME/webapps/helloworld.war

ADD ./init.sh $INIT_SCRIPT

RUN chmod +x $INIT_SCRIPT

CMD ["/usr/bin/init.sh"]
