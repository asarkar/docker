FROM abhijitsarkar/docker:debian-supervisor

ENV JAVA_HOME=/opt/java

WORKDIR /opt

RUN apt-get update && \
	curl -sSL -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz | tar xz && \
	find . -maxdepth 1 -type d -name "*jdk*" -exec ln -sf {} $JAVA_HOME \; && \
    update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 100 && \
    update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 100

CMD ["/bin/bash"]
