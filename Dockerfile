FROM node:6-alpine

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
    pip install -U pip ikpdb virtualenv &&\
    npm install --no-spin -g  \
      sqlite \
      sequelize \
      coffee \
      typescript \
      less \
      sass \
      stylus \
      nodemon \
      bower \
      http-server \
      npm-check-updates \
      nsp \
      underscore-cli \
      express-generator \
      mocha \
      eslint \
      jshint \
      grunt-cli \
      gulp \
      yo

COPY *.js* /root/.c9/
COPY ./node_modules /root/.c9/node_modules
COPY ./plugins /root/.c9/plugins
COPY ./user-plugins /root/.c9/user-plugins
COPY ./settings /root/.c9/settings
COPY ./local /root/.c9/local
COPY ./configs /root/.c9/configs

ENV PORT 8181
ENV IP 0.0.0.0
WORKDIR /root/.c9
RUN echo "#!/usr/bin/env bash" > /root/.c9/start &&\
    echo "IP=$IP node /root/.c9/server.js -p $PORT -a : $*" >> /root/.c9/start &&\
    chmod +x /root/.c9/start &&\
    npm install --no-spin &&\
    mkdir -p /root/.c9/node/bin/ &&\
    ln -s `which node` /root/.c9/node/bin/node &&\
    ln -s `which npm` /root/.c9/node/bin/npm

EXPOSE 8181
WORKDIR /root/.c9/
ENTRYPOINT /root/.c9/start
