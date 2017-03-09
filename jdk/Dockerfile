FROM abhijitsarkar/docker:debian-supervisor

ENV JAVA_HOME=/opt/java

WORKDIR /opt

RUN apt-get update && \
	apt-get install unzip && \
	curl -sSL -b "oraclelicense=a" http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz | tar xz && \
	curl -sSL -b "oraclelicense=a" -o ./jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
	find . -maxdepth 1 -type d -name "*jdk*" -exec ln -sf {} $JAVA_HOME \; && \
    update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 100 && \
    update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 100 && \
    unzip -p jce_policy-8.zip UnlimitedJCEPolicyJDK8/local_policy.jar > java/jre/lib/security/local_policy.jar && \
    unzip -p jce_policy-8.zip UnlimitedJCEPolicyJDK8/US_export_policy.jar > java/jre/lib/security/US_export_policy.jar && \
    chmod 644 java/jre/lib/security/*.jar && \
    rm -f jce_policy-8.zip

CMD ["/bin/bash"]
