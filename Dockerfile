FROM node:alpine

ENV IN_CONTAINER=true
RUN apk update
RUN apk upgrade
RUN apk add \
  curl \
  git \
  wget \
  ruby-dev \
  ruby \
  alpine-sdk \
  autoconf \
  automake \
  perl \
  libffi-dev \
  ruby-rdoc \
  ruby-irb \
  bash \
  python \
  file \
  zlib-dev \
  libjpeg-turbo-utils \
  nasm
RUN gem install compass sass
RUN npm install -g bower gulp-cli
RUN mkdir /var/www
RUN chown node:node /var/www

USER node

WORKDIR /var/www
