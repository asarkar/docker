FROM abhijitsarkar/docker:jdk8

ENV GRADLE_VERSION=2.10 MAVEN_VERSION=3.3.9 USERNAME=dev

RUN apt-get update && \
	apt-get -y install sudo vim git git-review unzip && \
	getent group $USERNAME || groupadd $USERNAME && \
	useradd -g $USERNAME -G sudo -s /bin/bash $USERNAME && \
	echo "$USERNAME:$USERNAME" | chpasswd && \
	mkdir -p /home/$USERNAME && \
	chown -R $USERNAME /home/$USERNAME

WORKDIR /opt

RUN curl -sSL -O https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip && \
	unzip -q gradle-$GRADLE_VERSION-bin.zip -d . && \
	rm -f gradle-$GRADLE_VERSION-bin.zip && \
	ln -sf $(pwd)/gradle-$GRADLE_VERSION $(pwd)/gradle && \
	ln -sf $(pwd)/gradle/bin/gradle /usr/local/bin/gradle && \
	find gradle/bin -type f -name "*.bat" -exec rm -f {} + && \
	curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xz && \
	ln -sf $(pwd)/apache-maven-$MAVEN_VERSION $(pwd)/maven && \
	ln -sf $(pwd)/maven/bin/mvn /usr/local/bin/mvn && \
	find maven/bin -type f -name "*.cmd" -exec rm -f {} +

CMD ["/bin/bash"]
