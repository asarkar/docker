FROM abhijitsarkar/docker:debian-base

RUN apt-get update && \
	apt-get install -y python-setuptools && \
  	easy_install supervisor

RUN mkdir -p /var/log/supervisor && \
  	mkdir -p /etc/supervisor/conf.d

ADD ./supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]