# Debian 8.x
FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y curl

# install supervisor
RUN apt-get -y install python-setuptools && \
  easy_install supervisor && \
  mkdir -p /var/log/supervisor && \
  mkdir -p /etc/supervisor/conf.d

ADD ./supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]