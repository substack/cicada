FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js && apt-get update

RUN apt-get update && apt-get install -y \
  apt-transport-https \
  curl \
  git \
  ssh \
  wget \
  vim \
  git \
  subversion \
  g++ \
  libnss3-dev \
  libasound2-dev \
  libpulse-dev \
  libjpeg62-dev \
  libxv-dev libgtk2.0-dev \
  libexpat1-dev \
  libxss-dev \
  libudev-dev \
  libdrm-dev \
  libgconf2-dev \
  libgcrypt11-dev \
  libpci-dev \
  libxtst-dev \
  libgnome-keyring-dev \
  libssl-dev \
  nodejs

RUN npm install -g forever

#Install docker
RUN sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
RUN sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
RUN apt-get update
RUN apt-get install -y lxc-docker

RUN service ssh start

WORKDIR /usr/bin
RUN wget http://stedolan.github.io/jq/download/linux64/jq

WORKDIR /opt
ADD . /opt/server

EXPOSE 22 3000

WORKDIR /opt/server
CMD ["forever", "example/ci.js"]
