FROM centos:7.5.1804

LABEL maintainer="PS <arbor@foxmail.com>"

ENV SENTINEL_USER="sentinel" \
    PROJECT_NAME="sentinel-dashboard" \
    JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk" \
    JAVA="/usr/lib/java-1.8.0-openjdk/bin/java" \
    TIME_ZONE="Asia/Shanghai" \
    BASE_DIR="/home/sentinel"

ARG SENTINEL_VERSION=1.7.0
ENV SENTINEL_PORT=3261

WORKDIR /$BASE_DIR

RUN set -x \
    && mkdir /opt/sentinel-dashboard \
    && mkdir /opt/sentinel-dashboard/bin \
    && yum update -y \
    && yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel wget iputils nc vim libcurl\
    && ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo '$TIME_ZONE' > /etc/timezone \
    && wget -O /opt/sentinel-dashboard/bin/sentinel-dashboard.jar "https://github.com/alibaba/Sentinel/releases/download/${SENTINEL_VERSION}/sentinel-dashboard-${SENTINEL_VERSION}.jar" \
    && yum clean all

EXPOSE ${SENTINEL_PORT}
CMD java ${JAVA_OPTS} -Dserver.port=${SENTINEL_PORT} -Dcsp.sentinel.dashboard.server=localhost:${SENTINEL_PORT} -Dproject.name=${PROJECT_NAME} -jar /opt/sentinel-dashboard/bin/sentinel-dashboard.jar