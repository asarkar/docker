FROM openjdk:8u131-jre-alpine

ENV ZEPPELIN_VERSION=0.7.2 ZEPPELIN_HOME=/opt/zeppelin
ENV PATH="${PATH}:$ZEPPELIN_HOME/bin"

WORKDIR /opt

RUN apk update && \
    apk add --no-cache bash curl && \
    curl -sSL http://www.apache.org/dyn/closer.cgi/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-netinst.tgz | tar xz && \
    find . -maxdepth 1 -type d -name "*zeppelin*" -exec ln -sf {} $ZEPPELIN_HOME \; && \
    find . -type f \( -name "*cmd" -o -name "*bat" \) -delete && \
    apk del curl

EXPOSE 8080 8081

CMD ["/opt/zeppelin/bin/zeppelin.sh", "start"]
