FROM debian:jessie

ENV CONTAINER=1

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget curl bash apt-utils -y
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

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
  openjdk-7-jre-headless \
  xvfb \
  gtk2-engines-pixbuf \
  xfonts-cyrillic \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-base \
  xfonts-scalable \
  imagemagick \
  x11-apps \
  google-chrome-stable \
  nodejs

RUN npm install -g bower gulp-cli protractor

# Add chrome xvfb to make e2e testt
ADD xvfb-chrome /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

ENV DISPLAY=:10

RUN mkdir /var/www
RUN useradd -ms /bin/bash node -G sudo -u 1000 -g 100
RUN chown node /var/www

# Add ecs-cli to deploy container to AWS
RUN curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
RUN chmod +x /usr/local/bin/ecs-cli

USER node

WORKDIR /var/www
