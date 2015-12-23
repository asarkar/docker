FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 TZ='America/Los_Angeles'

ADD ./debconf_preseed /etc/debconf_preseed

RUN debconf-set-selections /etc/debconf_preseed && \
	apt-get update && \
	apt-get install -y locales curl && \	
	dpkg-reconfigure tzdata && \
    dpkg-reconfigure locales

CMD ["/bin/bash"]