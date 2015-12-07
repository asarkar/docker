FROM debian:jessie

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

ADD ./debconf_preseed /etc/debconf_preseed

RUN debconf-set-selections /etc/debconf_preseed && \
	apt-get update && \
	apt-get install -y locales && \	
	dpkg-reconfigure tzdata && \
    dpkg-reconfigure locales && \
	apt-get install -y curl python-setuptools && \
  	easy_install supervisor

RUN mkdir -p /var/log/supervisor && \
  	mkdir -p /etc/supervisor/conf.d

ADD ./supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]