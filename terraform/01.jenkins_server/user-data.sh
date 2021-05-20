#!/bin/bash
sudo su -
yum remove java-1.7.0*
yum install java-1.8*
find /usr/lib/jvm/java-1.8* | head -n 3
JAVA_HOME=${find/usr/lib/jvm/java-1.8* | head -n 3}
export JAVA_HOME
PATH=$PATH:$JAVA_HOME
exit
sudo su -
yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins

service jenkins status
service jenkins start
chkconfig jenkins on
