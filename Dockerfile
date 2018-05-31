FROM ubuntu:16.04
MAINTAINER danrosg

USER root

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install curl -y
RUN apt-get install vim -y

RUN apt-get  install -y  \
    openssh-server \
    software-properties-common \
    python-software-properties \
