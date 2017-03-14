FROM node:latest

RUN apt-get update && apt-get install -y --force-yes \
      build-essential \
      openssl \
      python \
      python-pip \
      python-dev \
      wget \
      git \
      bash \
      tmux &&\
    pip install ikpdb

COPY . /opt/c9/core/
RUN /opt/c9/core/scripts/install-sdk.sh

RUN echo "#!/usr/bin/env bash" > /opt/c9/core/start &&\
    echo "IP=0.0.0.0 node /opt/c9/core/server.js -p 8181 -a : $*" >> /opt/c9/core/start &&\
    chmod +x /opt/c9/core/start &&\
    mkdir -p /workspace 

EXPOSE 8181
WORKDIR /workspace/
ENTRYPOINT /opt/c9/core/start
