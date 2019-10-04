FROM ubuntu:latest 
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean

ENV BEAT_VERSION=7.4.0 \
    FILEBEAT_HOME=/filebeat \
    PATH=${FILEBEAT_HOME}:$PATH

WORKDIR ${FILEBEAT_HOME}

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${BEAT_VERSION}-linux-x86_64.tar.gz

RUN tar -zxvf filebeat-${BEAT_VERSION}-linux-x86_64.tar.gz

RUN mv filebeat-${BEAT_VERSION}-linux-x86_64/* .

RUN apt-get purge -y curl

RUN ls -l ${FILEBEAT_HOME}

COPY filebeat.yml ${FILEBEAT_HOME}/filebeat.yml

CMD ["filebeat", "-e"]

