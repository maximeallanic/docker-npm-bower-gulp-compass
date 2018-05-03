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
  python2 \
  file \
  nasm \
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

# Java
RUN \
  curl -jkL -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz -o /opt/jdk-8u171-linux-x64.tar.gz \
  && tar -xzf /opt/jdk-8u171-linux-x64.tar.gz -C /opt \
  && rm /opt/jdk-8u171-linux-x64.tar.gz \
  && ln -s /opt/jdk1.8.0_171 /opt/jdk
ENV PATH $PATH:/opt/jdk/bin
ENV JAVA_HOME /opt/jdk
ENV _JAVA_OPTIONS -Djava.net.preferIPv4Stack=true

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
