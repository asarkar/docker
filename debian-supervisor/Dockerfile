FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	# curl
	apt-get install -y curl && \
	# supervisor
	apt-get -y install python-setuptools && \
  	easy_install supervisor

RUN mkdir -p /var/log/supervisor && \
  	mkdir -p /etc/supervisor/conf.d

ADD ./supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]