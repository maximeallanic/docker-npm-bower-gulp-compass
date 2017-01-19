FROM markadams/chromium-xvfb-js

ENV IN_CONTAINER=true

RUN apt-get update
RUN apt-get install -y\
  curl \
  git \
  wget \
  ruby-dev \
  ruby-all-dev \
  ruby-sass \
  ruby-compass \
  rubygems-integration \
  autoconf \
  automake \
  make \
  perl \
  libffi-dev \
  bash \
  python \
  file \
  nasm \
  default-jdk

RUN npm install -g bower gulp-cli

RUN mkdir /var/www
RUN useradd -ms /bin/bash node
RUN chown node:node /var/www

USER node

WORKDIR /var/www
