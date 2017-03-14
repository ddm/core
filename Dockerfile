FROM alpine

RUN apk add --update \
      build-base \
      openssl \
      python \
      python-dev \
      py-pip \
      sqlite \
      wget \
      git \
      bash \
      tmux &&\
    pip install -U pip ikpdb virtualenv

COPY . /opt/c9/core/
RUN bash /opt/c9/core/scripts/install-sdk.sh

RUN echo "#!/usr/bin/env bash" > /opt/c9/core/start &&\
    echo "node /opt/c9/core/server.js -p 8181 -a : $*" >> /opt/c9/core/start &&\
    chmod +x /opt/c9/core/start &&\
    mkdir -p /workspace 

EXPOSE 8181
WORKDIR /workspace/
ENTRYPOINT /opt/c9/core/start
