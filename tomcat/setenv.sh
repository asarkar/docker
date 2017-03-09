#!/bin/bash

export JAVA_OPTS="-DHTTP_PORT=${HTTP_PORT} -DDEBUG_PORT=${DEBUG_PORT} -DSHUTDOWN_PORT=${SHUTDOWN_PORT}"
export JPDA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=${SUSPEND_ON_DEBUG},address=${DEBUG_PORT}"