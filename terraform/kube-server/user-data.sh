#!/bin/bash -xe

sudo su -
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

apt-get update

DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get upgrade -yq

# install java
# /usr/bin/apt-get autoremove default-jdk openjdk-11-jdk -y
apt install openjdk-8-jdk openjdk-8-jre -y
apt-get update
java -version
cat >>~/.bashrc <<EOL

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
PATH="${JAVA_HOME}/bin:${PATH}"
EOL
source ~/.bashrc

# install utilities
apt install git -y
git --version
apt install python3-pip -y
pip3 install awscli
apt install unzip
wget -q https://releases.hashicorp.com/terraform/0.11.6/terraform_0.11.6_linux_amd64.zip
unzip terraform_0.11.6_linux_amd64.zip
mv terraform /usr/local/bin/terraform
terraform version

apt update
apt install maven -y
mvn -version
cat >>/etc/profile.d/maven.sh <<EOL

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export M2_HOME=/usr/share/maven
export M2=/usr/share/maven/bin
export MAVEN_HOME=/usr/share/maven
export PATH="${M2}:${M2_HOME}:${PATH}"
EOL
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version

echo "----- End of Updates -----"
