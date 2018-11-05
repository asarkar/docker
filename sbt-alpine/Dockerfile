FROM azul/zulu-openjdk-alpine:10

# An ARG declared before a FROM is outside of a build stage, so it can’t be used in any instruction after a FROM
ARG SBT_VERSION=1.2.6
ARG INSTALL_DIR=/usr/lib

ENV PATH=${PATH}:${INSTALL_DIR}/sbt/${SBT_VERSION}/bin

RUN apk --no-cache --update add ca-certificates bash curl git openssh tar gzip && \
  update-ca-certificates && \
  mkdir -p ${INSTALL_DIR}/sbt && \
  curl -sSL "https://piccolo.link/sbt-${SBT_VERSION}.tgz" | tar -xz -C ${INSTALL_DIR}/sbt && \
  mv -f ${INSTALL_DIR}/sbt/sbt ${INSTALL_DIR}/sbt/${SBT_VERSION}
