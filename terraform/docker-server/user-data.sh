#!/bin/bash

sudo su -
hostname docker-host
sudo su -
sudo yum update -y
sudo yum install java-1.8.0-openjdk -y
java -version
cat >>/etc/profile <<EOL

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.282.b08-1.amzn2.0.1.x86_64
export JRE_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.282.b08-1.amzn2.0.1.x86_64/jre
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
EOL
source /etc/profile

cat >>~/.bashrc <<EOL

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
PATH="${JAVA_HOME}/bin:${PATH}"
EOL
source ~/.bashrc

yum install docker -y
docker --version

# start docker services
service docker start
service docker status

# test by tomcat server
docker images ls
docker pull tomcat:latest
# expose it to port number 8080 and internally 8080 and run in background using the detach mode
docker run -d --name test-tomcat-server -p 8090:8080 tomcat:latest

# create a user called dockeradmin
# useradd dockeradmin
# passwd dockeradmin

# make user part of the docker group
# cat /etc/group
# usermod -aG docker dockeradmin
# id dockeradmin
