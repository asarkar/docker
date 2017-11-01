FROM alpine

RUN apk add --no-cache bash curl jq && \
  mkdir /etc/sidecar

COPY *.sh /usr/sbin/
COPY sidecar.* /etc/sidecar/

CMD ["/usr/sbin/init.sh"]
