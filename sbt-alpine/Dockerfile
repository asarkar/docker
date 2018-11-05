ARG JDK_VERSION=openjdk11

FROM adoptopenjdk/${JDK_VERSION}:alpine

# An ARG declared before a FROM is outside of a build stage, so it can’t be used in any instruction after a FROM
ARG SBT_VERSION=1.2.6
ARG INSTALL_DIR=/opt

ENV PATH=${INSTALL_DIR}/sbt/bin:${PATH}

RUN apk add --no-cache --update bash git openssh && \
  apk add --no-cache --virtual build-deps curl tar gzip && \
  curl -sSL "https://piccolo.link/sbt-${SBT_VERSION}.tgz" | tar -xz -C "${INSTALL_DIR}" && \
  apk del build-deps
