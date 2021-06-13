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

# install kube ctl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# install kops
curl -LO https://github.com/kubernetes/kops/releases/download/1.15.0/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
kops

echo "----- End of Updates -----"
