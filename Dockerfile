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

#ssh passwordless auth

RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# installing java

RUN wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz"

RUN mkdir /opt/jdk
RUN tar -zxf jdk-8u171-linux-x64.tar.gz -C /opt/jdk
RUN rm jdk-8u171-linux-x64.tar.gz

#creating a folder structure for hadoop installation

RUN ["/bin/bash", "-c", "mkdir -p /opt/{hadoop/logs,hdfs/{datanode,namenode}}"]

ENV JAVA_HOME /opt/jdk/jdk1.8.0_171
ENV PATH $PATH:$JAVA_HOME/bin

ENV HADOOP_HOME /opt/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
#ENV SPARK_HOME /opt/spark
#ENV SPARK_CONF_DIR /opt/spark/conf
#ENV SPARK_MASTER_HOST localhost

ENV DIST=http://www-eu.apache.org/dist

RUN wget -c -O hadoop.tar.gz $DIST/hadoop/common/hadoop-3.1.0/hadoop-3.1.0.tar.gz
RUN tar xvf hadoop.tar.gz \
    --directory=$HADOOP_HOME \
    --exclude=hadoop-3.1.0/share/doc \
    --strip 1
RUN rm hadoop.tar.gz

COPY core-site.xml $HADOOP_CONF_DIR/
COPY hdfs-site.xml $HADOOP_CONF_DIR/

RUN hdfs namenode -format
RUN service ssh start
#RUN start-dfs.sh
