FROM ubuntu:16.04
MAINTAINER danrosg

USER root

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y curl wget vim

RUN apt-get install -y  \
    openssh-server \
    software-properties-common \
    python-software-properties

RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"
