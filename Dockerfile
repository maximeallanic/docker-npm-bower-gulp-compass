FROM debian:jessie

ENV IN_CONTAINER=true

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install wget curl bash -y
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
  nodejs \
  supervisor \
  fluxbox \
  sudo

RUN npm install -g bower gulp-cli protractor

COPY supervisord.conf /etc/
#RUN ln /usr/lib/node_modules/protractor/selenium/chromedriver /usr/bin/chromedriver
#ADD xvfb-chrome /usr/bin/xvfb-chromium
#RUN rm /usr/bin/google-chrome
#RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
#RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser
#RUN chmod +x /usr/bin/xvfb-chromium /usr/bin/google-chrome /usr/bin/chromium-browser


ENV DISPLAY=:10

RUN mkdir /var/www
RUN useradd -ms /bin/bash node -G sudo -u 1000 -g 100
RUN chown node /var/www
RUN echo 'ALL ALL = (ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

CMD sudo supervisord -c /etc/supervisord.conf

USER node

ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

WORKDIR /var/www

