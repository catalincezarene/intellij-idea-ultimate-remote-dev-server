FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl git gosu && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /ide.tar.gz https://download.jetbrains.com/idea/ideaIU-2022.1.tar.gz && \
    mkdir /ide && \
    tar xfz /ide.tar.gz --strip-components=1 -C /ide && \
    rm /ide.tar.gz

ENV PROJECT_DIR="/project"

COPY remote-dev-server /usr/local/bin/

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD []
