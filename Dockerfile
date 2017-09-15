FROM node:alpine

# Set env to detect if there in a container, or not
ENV CONTAINER=1

USER root

# Install base
RUN apk update
RUN apk upgrade
RUN apk add \
  wget \
  bash \
  chromium \
  curl \
  git \
  wget \
  autoconf \
  automake \
  sudo \
  g++ \
  make \
  perl \
  libffi-dev \
  bash \
  python \
  file \
  nasm \
  openjdk8 \
  libsass \
  xvfb \
  imagemagick \
  libjpeg-turbo-utils \
  gifsicle \
  optipng \
  udev \
  zlib-dev \
  wait4ports \
  xorg-server \
  dbus \
  ttf-freefont \
  mesa-dri-swrast

# Set java path
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

# Prepare Workdir
RUN mkdir /var/www
RUN chown node:node /var/www
RUN echo "node ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install npm dependencies
RUN npm install -g bower gulp-cli protractor

# Add chrome xvfb to make e2e test
ADD xvfb-chrome /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN chmod +x /usr/bin/xvfb-chromium
ENV CHROME_BIN=/usr/bin/xvfb-chromium
ENV DISPLAY=:10

USER node

WORKDIR /var/www
