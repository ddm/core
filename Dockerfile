FROM dimdm/node:6.11.3

COPY ./node_modules /root/.c9/node_modules
COPY ./plugins /root/.c9/plugins
COPY ./local /root/.c9/local
COPY *.js* /root/.c9/
COPY ./settings /root/.c9/settings
COPY ./configs /root/.c9/configs
COPY ./user-plugins /root/.c9/user-plugins

WORKDIR /root/.c9
RUN apk add --update \
      build-base \
      gcc \
      openssl \
      python \
      py-pip \
      python-dev \
      docker \
      wget \
      git \
      bash \
      tmux &&\
    pip install -U \
      pip \
      ikpdb \
      virtualenv \
      docker-compose &&\
    find -path node_modules -prune -type d -print0 | xargs -t -I {} cd {} && npm install --no-spin &&\
    cd /root/.c9 &&\
    npm install --no-spin -g  \
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
      yo &&\
    npm install --no-spin &&\
    mkdir -p /root/.c9/node/bin/ &&\
    ln -s `which node` /root/.c9/node/bin/node &&\
    ln -s `which npm` /root/.c9/node/bin/npm &&\
    echo "#!/usr/bin/env bash" > /root/.c9/start &&\
    echo "node /root/.c9/server.js -p 8181 -a : $*" >> /root/.c9/start &&\
    chmod +x /root/.c9/start

ENV IP=0.0.0.0
EXPOSE 8181 8080
CMD /root/.c9/start
