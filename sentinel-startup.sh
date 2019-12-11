#!/usr/bin/env bash

java -Dserver.port=${SENTINEL_PORT} \
    -Dcsp.sentinel.dashboard.server=localhost:{$SENTINEL_PORT} \
    -Dproject.name=${PROJECT_NAME} -jar /opt/sentinel-dashboard/bin/sentinel-dashboard.jar