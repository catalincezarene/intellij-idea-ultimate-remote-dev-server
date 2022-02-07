FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y curl git gosu && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL -o /ide.tar.gz https://download-cdn.jetbrains.com/idea/ideaIU-2021.3.2.tar.gz && \
    mkdir /ide && \
    tar xfz /ide.tar.gz --strip-components=1 -C /ide && \
    rm /ide.tar.gz

COPY remote-dev-server /usr/local/bin/

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD []
