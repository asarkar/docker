FROM openjdk:8u111-alpine

ENV SCALA_VERSION=2.11.8 SPARK_VERSION=2.1.0 SCALA_HOME=/opt/scala SPARK_HOME=/opt/spark
ENV PATH="${PATH}:$SCALA_HOME/bin:$SPARK_HOME/bin"

WORKDIR /opt

RUN apk update && \
    apk add --no-cache bash curl && \
    curl -sSL http://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xz && \
    curl -sSL http://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_VERSION-bin-hadoop2.7.tgz | tar xz && \
    find . -maxdepth 1 -type d -name "*scala*" -exec ln -sf {} $SCALA_HOME \; && \
    find . -maxdepth 1 -type d -name "*spark*" -exec ln -sf {} $SPARK_HOME \; && \
    find . -type f \( -name "*cmd" -o -name "*bat" \) -delete && \
    apk del curl

CMD ["/bin/bash"]
