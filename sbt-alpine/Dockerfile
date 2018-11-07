ARG JDK_VERSION=11

FROM azul/zulu-openjdk-alpine:${JDK_VERSION}

# An ARG declared before a FROM is outside of a build stage, so it can’t be used in any instruction after a FROM
ARG SBT_VERSION=1.2.6

RUN INSTALL_DIR=/usr/lib && \
  BIN_DIR=/usr/bin && \
  apk add --no-cache --update bash git openssh && \
  apk add --no-cache --virtual build-deps curl tar gzip && \
  curl -sSL "https://piccolo.link/sbt-${SBT_VERSION}.tgz" | tar -xz -C "${INSTALL_DIR}" && \
  find ${INSTALL_DIR}/sbt/bin -type f -perm -a=x -exec ln -s {} ${BIN_DIR} \; && \
  apk del build-deps
