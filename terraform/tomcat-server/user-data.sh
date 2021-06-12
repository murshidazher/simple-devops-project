#!/bin/bash

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

cd /opt
export VER="8.5.66"
wget https://downloads.apache.org/tomcat/tomcat-8/v${VER}/bin/apache-tomcat-${VER}.tar.gz
tar -xvzf /opt/apache-tomcat-${VER}.tar.gz
mv apache-tomcat-${VER} tomcat
chmod +x /opt/tomcat/bin/startup.sh
chmod +x /opt/tomcat/bin/startup.sh
rm -f /usr/local/bin/tomcatup
rm -f /usr/local/bin/tomcatdown
ln -s /opt/tomcat/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/tomcat/bin/shutdown.sh /usr/local/bin/tomcatdown
tomcatup

# basic tomcat server setup, for using it with jenkins configure the port number to 8090. Refer to [tomcat installation](./notes/tomcat/01.tomcat_installation.MD)
