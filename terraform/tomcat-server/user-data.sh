#!/bin/bash

sudo yum update -y
cd /opt
sudo wget http://mirrors.fibergrid.in/apache/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz
sudo tar -xvzf /opt/apache-tomcat-8.5.35.tar.gz
sudo chmod +x /opt/apache-tomcat-8.5.35/bin/startup.sh
sudo shutdown.sh
sudo ln -s /opt/apache-tomcat-8.5.35/bin/startup.sh /usr/local/bin/tomcatup
sudo ln -s /opt/apache-tomcat-8.5.35/bin/shutdown.sh /usr/local/bin/tomcatdown
sudo tomcatup

# basic tomcat server setup, for using it with jenkins configure the port number to 8090. Refer to [tomcat installation](./notes/tomcat/01.tomcat_installation.MD)
