# [simple-devops-project](https://github.com/murshidazher/simple-devops-project)

> A simple devops project with the use of jenkins, ansible, docker, kubernetes, tomcat, aws

## Table of Contents

- [simple-devops-project](#simple-devops-project)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
    - [1. Setup CI/CD with Jenkins, Git, Maven and Tomcat](#1-setup-cicd-with-jenkins-git-maven-and-tomcat)
    - [2. Introducing Docker](#2-introducing-docker)
    - [3. Integration with Ansible](#3-integration-with-ansible)
    - [4. Introducing Kubernetes](#4-introducing-kubernetes)
  - [What is CI/CD ?](#what-is-cicd-)
  - [Jenkins Deploy on EC2/VM](#jenkins-deploy-on-ec2vm)
    - [Jenkins Installation](#jenkins-installation)
    - [Creating the Infra using Terraform](#creating-the-infra-using-terraform)
    - [Creating a Job](#creating-a-job)
    - [Github Setup](#github-setup)
    - [Maven Setup](#maven-setup)
  - [Integrating Tomcat server in pipeline](#integrating-tomcat-server-in-pipeline)
    - [Install Tomcat](#install-tomcat)
    - [Integrate Tomcat server with Jenkins](#integrate-tomcat-server-with-jenkins)
    - [Automatic Deploy on Code change](#automatic-deploy-on-code-change)
  - [Integrating Docker in pipeline](#integrating-docker-in-pipeline)
    - [Docker env setup](#docker-env-setup)
    - [Integrating Docker host with Jenkins server](#integrating-docker-host-with-jenkins-server)
    - [Jenkins job to copy artifacts onto Dockerhost](#jenkins-job-to-copy-artifacts-onto-dockerhost)
    - [Create a Dockerfile to container](#create-a-dockerfile-to-container)
    - [Deploying a war file on Docker container using Jenkins](#deploying-a-war-file-on-docker-container-using-jenkins)
    - [Limitation of Jenkins as Deployment tool](#limitation-of-jenkins-as-deployment-tool)
  - [Integrating Ansible in pipeline](#integrating-ansible-in-pipeline)
    - [Ansible Environment Setup](#ansible-environment-setup)
    - [Integrate Ansible with Jenkins](#integrate-ansible-with-jenkins)
    - [Create an Ansible Playbook](#create-an-ansible-playbook)
    - [Run Ansible Playbook from Jenkins](#run-ansible-playbook-from-jenkins)
    - [DockerHub Integration with Ansible](#dockerhub-integration-with-ansible)
    - [Tagging images with Ansible Playbook](#tagging-images-with-ansible-playbook)
      - [Create playbook to push image to Dockerhub](#create-playbook-to-push-image-to-dockerhub)
      - [Create pull playbook for Docker hosts](#create-pull-playbook-for-docker-hosts)
    - [Jenkins Job to deploy on Docker container through Dockerhub](#jenkins-job-to-deploy-on-docker-container-through-dockerhub)
    - [Jenkins job to deploy a war file on Docker container using Ansible](#jenkins-job-to-deploy-a-war-file-on-docker-container-using-ansible)
  - [Integrating Kubernetes in pipeline](#integrating-kubernetes-in-pipeline)
    - [Setting up Kubernetes with AWS EC2](#setting-up-kubernetes-with-aws-ec2)
    - [Create deployment and service YAML files](#create-deployment-and-service-yaml-files)
    - [Integrate Ansible Playbooks with Kubernetes](#integrate-ansible-playbooks-with-kubernetes)
    - [Create deployment and service using Ansible](#create-deployment-and-service-using-ansible)
    - [Jenkins CD Job to deploy on kubernetes](#jenkins-cd-job-to-deploy-on-kubernetes)
    - [Jenkins CI job for creating Docker image](#jenkins-ci-job-for-creating-docker-image)
    - [Integrating Jenkins CI/CD job to deploy on k8s](#integrating-jenkins-cicd-job-to-deploy-on-k8s)
    - [Automate deployment on k8s using Jenkins CI/CD](#automate-deployment-on-k8s-using-jenkins-cicd)
    - [Setup CI/CD Job for k8s](#setup-cicd-job-for-k8s)
  - [License](#license)

## Overview

### 1. Setup CI/CD with Jenkins, Git, Maven and Tomcat

- Setup Jenkins
- Run a test job
- Setup & configure Maven and Git
- Setup Tomcat Server
- Installing additional required plugins
- Integrating Git, Maven in Jenkins job
- Run CI/CD job

<details>
  <summary>Architecture</summary>
  <img src="./docs/1.png"/>
</details>


### 2. Introducing Docker

- Setting up Docker environment
- Managing Docker with Ansible
- DockerHub repository
- Writing a Docker file
- Run a job

<details>
  <summary>Architecture</summary>
  <img src="./docs/2.png"/>
</details>

### 3. Integration with Ansible

- Setting up Ansible environment
- Integrating Ansible with Jenkins
- Writing a Ansible playbook to deploy on container
- Run a job

<details>
  <summary>Architecture</summary>
  <img src="./docs/3.png"/>
</details>

### 4. Introducing Kubernetes

- Setting up Kubernetes environment
- Write deployment and service files
- Run a job

<details>
  <summary>Architecture</summary>
  <img src="./docs/4.png"/>
</details>

## What is CI/CD ?

- Continuos Integration (CI)
- Continuos Delivery (CD) - There will be a manual intervention to deploy to env
- Continuos Deployment (CD) - No manual intervention
- CI process with result in an artifact which is used in the staging env.

<details>
  <summary>CI/CD Architecture</summary>
  <img src="./docs/5.png"/>
</details>

- If this whole process happens without any manual intervention then its continuos deployment.
  
<details>
  <summary>Continuous deployment Architecture</summary>
  
  <img src="./docs/6.png"/>
  <img src="./docs/7.png"/>
</details>

## Jenkins Deploy on EC2/VM

- Jenkins pulls the code from git and deploys the code to EC2 instance running tomcat.

<details>
  <summary>EC2 Architecture</summary>
  <img src="./docs/9.png"/>
</details>

### Jenkins Installation

> The whole documentation for installation can be found [here](jenkins/01.jenkins_installation.MD)

- Go into aws console and create an EC2 instance
- We can use `MobaXterm` or PuTTy to connect to the server, but we don't need to convert the key when using with `MobaXTerm`

<details>
  <summary>Jenkins Architecture</summary>
  <img src="./docs/8.png"/>
</details>

```sh
> sudo su - # be the root user
> java -version # we need 1.8
> yum remove java-1.7.0* # remove 1.7
> yum install java-1.8*
```

- We need to download LTS (Long Term Support) version of redhat and fedora version.
- Access jenkins in the browser

```sh
http://YOUR-SERVER-PUBLIC-IP:8080
> cat /var/lib/jenkins/secrets/initialAdminPassword # to find the autogenerated password
```

- Don't need to install jenkins plugins for now. Close it we will install it based on necessities.
- Start using jenkins.
- Change the admin password, `admin` > `configure` > `password` > `apply` 
- Manage jenkins > Global tool configuration > Add JDK
  - Name: `JAVA_HOME`
  - JAVA_HOME: `paste the path`
- `apply` > `save`

```sh
> ssh -o IdentitiesOnly=yes -i key.pem ec2-user@x.x.x.x
> echo $JAVA_HOME #copy the path
```

### Creating the Infra using Terraform

> If you don't want to manually create the ec2 instance, we can run the terraform code.

- Create a s3 bucket manually named `javahome-tf-1212`

```sh
> cd terraform/jenkins-ci/config
> AWS_DEFAULT_REGION=us-east-1 aws ec2 create-key-pair --key-name jenkins --query 'KeyMaterial' --output text > jenkins.pem
```

To provision the infrastructure using terraform,

```sh
> terraform init
> terraform plan 
> terraform apply -auto-approve
> terraform output
```

### Creating a Job

- Go to `New Item` > `Jobs` > Give it a name
- Give some description and for now the source code is `none` since we haven't installed any source code management plugins.
- Build select `execute shell` because our target system is `ubuntu`
- We can `Apply` > `Save`
- If we need to edit it again we can press configure else we can do an initial build.

### Github Setup

> Read documentation on [github jenkins setup](./notes/jenkins/Git_plugin_install.MD).

- The first step of installation can be skipped if we use terraform code to spin up the ec2 instance.

### Maven Setup

> Read documentation on [maven setup](./notes/jenkins/maven_install.MD).

- Sometimes in ubuntu the maven home would be `/usr/share/maven`
- Now, lets create a new item. `MyFirstMavenBuild` > Select `Maven Project`
- To build with maven we need to have source code. Get the git clone url `https://github.com/murshidazher/simple-devops-hello-world.git` of the source code.
- Choose git and provide the repository url.
- Goals: `clean install package`
- Apply and save
- Build now
- Workspace will contain all the files of the repo and the build maven war file can be found in `webapp > target > webapp.war`
- You can find then locally under `cd /var/lib/jenkins/workspace`
- Though we have a war file, we currently don't have any `target environment` to host these files. So we need to setup a tomcat server to host the war file.

## Integrating Tomcat server in pipeline

### Install Tomcat

> Read documentation on [how to setup a tomcat server](./notes/tomcat/01.tomcat_installation.MD).

- We need to create a new `ec2` instance to host the tomcat server.
- We also need to create users so that tomcat server will allows jenkins server to host the war file. So we need to create couple of users and roles.

```sh
> cd terraform/tomcat-server/config
> AWS_DEFAULT_REGION=us-east-1 aws ec2 create-key-pair --key-name tomcat --query 'KeyMaterial' --output text > tomcat.pem
> chmod 400 tomcat.pem
```

To provision the infrastructure using terraform,

```sh
> terraform init
> terraform plan 
> terraform apply -auto-approve
> terraform refresh
> terraform output
```

- Login to the instance and setup the necessary port numbers.
- We need to also add some users in `context.xml` so users can log into the `ManagerApp` tomcat server from outside.
- `find / -name context.xml` and edit the files under `webapps`.

### Integrate Tomcat server with Jenkins

- We need to integrate tomcat server with jenkins for deployment.
- Go to the jenkins serve and to install on vm we need an additional plugin called `deploy to container`. So we need to install it.
- Create a new job to deploy to vm > `new item` > `deploy_on_tomcat_server` > `maven project`
- Choose git and give the repository url. Select `main` branch.
- Goals: `clean install package`
- Since we need to deploy it once successful, we need to add `post-build action` > `deploy war/ear to a container`  > give the war file location > `**/*.war`
- Select `add to container` > `tomcat v8` > to deploy to tomcat server it should accept jenkins credentials. Since we created couple of users we can use those users.
- Give the `deployer` credential and add the tomcat url `http://x.xx.xx.x:8080/` > Apply > Save
- Run the job by pressing `Build now`.
- So now when we run this job it will deploy the war file to tomcat server. The jenkins will copy the files to `/opt/tomcat/webapps/` directory.
- To access the application we need to give the war file name. i.e. `http://x.xx.xx.x:8080/webapp`

### Automatic Deploy on Code change

> How to automatically trigger a new build on code change ?

- Edit `deploy_on_tomcat_server` and configure
- Scroll down and then `Build trigger` section, if we specify `build periodically` then we need to add a cron job.
- `PollSCM` also is like cron job where it will fetch the repository periodically. If there wasnt any changes during that period of time, then it wont trigger that job. `* * * * *` - every minute, every hour, every day, every week, every month it should get executed. If you need to execute once a day around 12'o clock `00 12 * * *`
- Now if we push a code change, it will be automatically triggered.
- Here we are using jenkins as build and deployment tool.

## Integrating Docker in pipeline

> In this instead of deploying it into tomcat server we will deploy it to docker host.

### Docker env setup

- Docker containers are created out of docker images which are created using Dockerfile.
- We can use the images from Dockerhub. If we need to pull images from private repositories then we need to login to docker using `docker login`.

### Integrating Docker host with Jenkins server

- We need to connect jenkins server with docker host server, so that it can transfer the host war files.
- For this purpose we need to install a plugin called `Publish over SSH` in our jenkins server. Then we need to add docker host credentials to the jenkins server so that jenkins server can authenticate itself using this credentials.
- To add docker server credentials in jenkins, we need to create a user called  `dockeradmin` in docker server.
- Now, we need to give the docker credentials in jenkins server. `Manage Jenkins` > `Configure system` > `Publish over SSH` > `SSH Server` > `Add`
  - `Name` : `docker-host`
  - `Hostname`: give the ip address `ip addr` without `/32`
  - `username`: `dockeradmin`
  - `Advance` > use password authentication checkbox
  - `password`: `dockeradmin` and test configuration
- We need to enable the password based authentication in docker server,

`vi /etc/ssh/sshd_config`

```sh
# EC2 use keys for remote access
PasswordAuthentication yes
```

- restart ssh > `service sshd reload`
- now test the configuration > apply and save

### Jenkins job to copy artifacts onto Dockerhost

- Create a new jenkins job called `deploy_on_docker`
- Instead of choosing maven copy all the configurations from `deploy_on_tomcat_server`
- Disable `PollSCM` for this job
- Delete the `deploy on vm` post build action
- Select `Send build artifacts over SSH` > this will send the artifacts to target server through ssh
- Transfer set
  - source files: `webapp/target/*.war`
  - remove prefix (while copying it copies the directory structure as well): `webapp/target`
  - remote directory: `.`
  - exec command: ``
- `apply` > `save`
- `build now`

To check if the file was transferred,

```sh
> su - dockeradmin
> pwd
> whoami
> ls
```

### Create a Dockerfile to container

- Now we need to copy the `webapp.war` to a docker container. We need to write a dockerfile which can create a tomcat server and host this war file.
- In the docker host server create a dockerfile, `vi Dockerfile`

```sh
# Pull base image 
From tomcat:8-jre8 

# Maintainer 
COPY ./webapp.war /usr/local/tomcat/webapps
```

- To create an image out of this,

```sh
# create an image called devops-project from current folder dockerfile
> docker build -t devops-project .
> docker images
# create a container out of the image
> docker run -d --name devops-container -p 8080:8080 devops-project
```

- Now if you go to the web browser `http://<ip_of_docker_server>:8080/webapp`

### Deploying a war file on Docker container using Jenkins

- Create a new job in jenkins server `deploy_on_container` > copy from: `deploy_on_docker`
- Change post build actions, `exec command`

```sh
cd /home/dockeradmin; 
docker build -t devops-image .;
docker run -d --name devops-container -p 8080:8080 devops-image;
```

### Limitation of Jenkins as Deployment tool

> Use `ansible` as deployment tool while `jenkins` as build tool.

- Jenkins cant be used as a full-fledged deployment tools for example if the war file is already available then the file is going to fail.
- So to overcome these problems we're going to use `ansible` as our deployment tool.
- If you have 100s of deployment location then its a difficult task for jenkins. These kind of problem are hectic to handle with jenkins.
- Hence we're only going to use jenkins as a `build tool` not a deployment tool.

## Integrating Ansible in pipeline

Now we will integrate ansible to the pipeline, so we can deploy on docker.

<details>
  <summary>Integrating Ansible Architecture</summary>
  <img src="./docs/3.png"/>
</details>

### Ansible Environment Setup

> Read documentation on [how to setup an ansible environment](./notes/ansible/Ansible_installation.MD).

- We need to create a user called `ansadmin` to create and store docker images in registry.
- Follow the rest of the instructions in the installation file.
- We need to enable the password based authentication in docker server, `vi /etc/ssh/sshd_config`,

```sh
# EC2 use keys for remote access
PasswordAuthentication yes
```

- change the hostname to make it easier to identify,

```sh
> hostname ansible-control-node
> sudo su -
```

- In the docker host server too create an `ansadmin` user, use the same password used in ansible server,

```sh
> useradd ansadmin
> passwd ansadmin # enter the password and remember it 
``` 

- Now we need to copy the `pem` keys from ansible server to docker host ec2 server.

```sh
# in ansible ec2
> sudo - ansadmin
> ssh-copy-id ansadmin@<docker-ec2-ip> # provide the password for first time
> ssh-copy-id localhost # so it copies the key under localhost
> ssh ansadmin@<docker-ec2-ip> # now will be able to login to target system
> exit
```

- We will create a folder for the files, we add permission so that it doesnt give an permission issue when copying the files.

```sh
> cd /opt
> mkdir docker
> sudo chown -R ansadmin:ansadmin /opt/docker # give full access to the folder
> ls -l /opt
```

- Now will create a `host` file to check the connectivity. 

```sh
> cd /etc/ansible
> sudo vi hosts
```

```txt
<add-docker-host-ip>
localhost
```

- Lets do a build test,

```sh
> ansible all -m ping
```

### Integrate Ansible with Jenkins

> Create an ansible job in jenkins, look into this [documentation](./notes/jenkins_jobs/Deploy_on_Container_using_Ansible.MD).

- Go into the jenkins control > `manage jenkins` > `configure system`
- similar to docker host in publish over SSH add a new config
  - `Name` : `ansible-server`
  - `Hostname`: give the ip address of ansible host `ip addr` without `/32`
  - `username`: `ansadmin`
  - `Advance` > use password authentication checkbox
  - `password`: `give the ansadmin password` and test configuration
  - `apply` > `save`
- Create a job > `deploy_on_container_using_ansible` > copy from: `deploy_on_container`
  - Enable `PollSCM` > `* * * * *`
  - SSH Name: `ansible-server`
  - Remote directory: `//opt/docker`
  - Exec command: ``
- `Build now`
- We also need to create a Dockerfile in the ansible server so that we can create the docker image.

### Create an Ansible Playbook

- Login to the ansible server
- Copy over same dockerfile to `/opt/docker` in the `ansible-host` server.
- Then we will write an ansible playbook to automate the creation of docker image.
- create a file called `simple-devops-image.yml`, refer this file [create-docker-image.yml](notes/jenkins_jobs/create-docker-image.yml)
  - `become: true` makes root privileges
  - `chdir` go inside this folder.
- create a local host file to create the docker image locally, `vi hosts` > add `localhost`
- `--check` flag will show you how the playbook is going to be executed

```sh
> ansible-playbook -i hosts simple-devops-image.yml --check
> ansible-playbook -i hosts simple-devops-image.yml
> docker images
```

- we can create another playbook or use the same yml file to create a container, [create-docker-container.yml](notes/jenkins_jobs/create-docker-container.yml)

```sh
> ansible-playbook -i hosts create-docker-container.yml --check
> ansible-playbook -i hosts create-docker-container.yml
> docker ps -a
```

### Run Ansible Playbook from Jenkins

- Before running the playbook from jenkins, remove all the containers,

```sh
> docker ps -a
> docker rm <id>
> docker images
> docker rmi simple-docker-image tomcat
```

- Go to ansible dashboard > edit the job `deploy_on_container_using_ansible` > `configure`
- Go to exec command;

```sh
> ansible-playbook -i /opt/docker/hosts /opt/docker/simple-devops-image.yml;
> ansible-playbook -i /opt/docker/hosts /opt/docker/create-docker-container.yml;
```

- Apply > Save > build now
- When the job is done `http://<ip-address-of-ansible>:8080/webapp` will be hosted currently in the ansible server.
- If we run the job the second time it will fail because we cant create two container with the same name. To overcome this problem we need to remove the existing container before creating a new container.
- Create a new playbook called [simple-docker-project.yml](notes/jenkins_jobs/simple-docker-project.yml). `Ignore error: yes` meaning that if there is no running container it wont throw an error.
- change the exec command in the job,

```sh
> ansible-playbook -i /opt/docker/hosts /opt/docker/simple-docker-project.yml;
```

### DockerHub Integration with Ansible

- In real world, ansible might have to manage hundreds of servers to push the images. In this case we would leverage another tool called `DockerHub`.
- So whenever, we build an image we will store that image in dockerhub. Whenever, the target environment builds an image then it will pull it from dockerhub and creates it own container.
- Create a [docker hub](https://hub.docker.com) account.
- Go to ansible server,
- Create an image to push into docker hub,

```sh
> docker images
> ansible-playbook -i hosts simple-docker-project.yml
> docker images
> docker tag simple-docker-project <dockr_hub_username>/simple-docker-project
> docker login 
> docker push <dockr_hub_username>/simple-docker-project
> docker rmi simple-docker-project # remove from local system
> docker pull <dockr_hub_username>/simple-docker-project # pull img from hub
```

- We need to pull the same image to all managed docker hosts, go to docker server

```sh
> su - ansadmin
> id # see if the user is added to docker group
> exit # exit if not
> usermod -aG docker ansadmin
> su - ansadmin
> docker pull <dockr_hub_username>/simple-docker-project
```

- Now, we can create containers out of this image.

### Tagging images with Ansible Playbook

- We need two ansible playbooks,
  - one to run on `ansible-server` to build the images and push it on dockerhub.
  - second playbook will be on all the target docker servers, whenever we run that playbook it will pull the image and build the containers out of it.

#### Create playbook to push image to Dockerhub

- create the first ansible playbook in `ansible-host-server`, `create-simple-devops-image.yml`

```yml
---
- hosts: ansible-server
  become: true

  tasks:
  - name: create docker image using war file
    command: docker build -t simple-devops-image:latest .
    args:
      chdir: /opt/docker

  - name: create tag to image
    command: docker tag simple-devops-image murshidazher/simple-devops-image

  - name: push image on to dockerhub
    command: docker push murshidazher/simple-devops-image

  - name: remove docker images form ansible server
    command: docker rmi simple-devops-image:latest murshidazher/simple-devops-image
    ignore_errors: yes
```

```sh
> ansible-playbook -i hosts create-simple-devops-image.yml
```

#### Create pull playbook for Docker hosts

- Create another playbook in `ansible-host` server called `create-simple-devops-project.yml`

```yml
---
- hosts: all
  become: true
  tasks:
  - name: stop if we have old docker container
    command: docker stop simple-devops-container
    ignore_errors: yes

  - name: remove stopped docker container
    command: docker rm simple-devops-container
    ignore_errors: yes

  - name: remove current docker image
    command: docker rmi murshidazher/simple-devops-image:latest
    ignore_errors: yes


  - name: pull image from dockerhub
    command: docker pull murshidazher/simple-devops-image
    args:
      chdir: /opt/docker

  - name: creating docker image
    command: docker run -d --name simple-devops-container -p 8080:8080 murshidazher/simple-devops-image:latest
```

```sh
> ansible-playbook -i hosts create-simple-devops-project.yml
```

- Now, lets add the target system ips in the host file

```sh
> vi /opt/docker/hosts
localhost
<ip_addr_docker_host>
```

### Jenkins Job to deploy on Docker container through Dockerhub

- We've two playbooks in the `ansible-host-server`,
  - `create-simple-devops-image.yml` to push image into dockerhub
  - `create-simple-devops-project.yml` to pull image from dockerhub
- We need to only run the `create-simple-devops-image.yml` on `ansible-host`, for that we can use the `limit` flag to limit it to only one host in the `hosts` file.

```sh
> ansible-playbook -i hosts create-simple-devops-image.yml --limit localhost
```

- Similarly, we need to run the `create-simple-devops-project.yml` playbook only on the dockerhost.
- To test the script, remove any running container in `docker-host`

```sh
> docker ps -a 
> docker stop <id>
> docker rm <id>
> docker images
> docker rmi murshidazher/simple-devops-image
```

- Now execute the playbook from `ansible-server`

```sh
> ansible-playbook -i hosts create-simple-devops-project.yml --limit <ip_addr_docker_host>
```

### Jenkins job to deploy a war file on Docker container using Ansible

- Next, we need to automate the above process to work through the jenkins job itself.
- Create a new job called `deploy_on_docker_container_using_ansible_playbook` > copy from: `deploy_on_container_using_ansible` > ok
- Change the exec command

```sh
ansible-playbook -i /opt/docker/hosts /opt/docker/create-simple-devops-image.yml --limit localhost;
ansible-playbook -i /opt/docker/hosts /opt/docker/create-simple-devops-project.yml --limit <ip_addr_docker_host>;
```

- Apply and save

💡 Now assume that due to some problem your docker container is not working. We need to create it manually or we should re-run our jenkins job. But jenkins job will only get executed when there is a new build. To overcome this problem, we need some technology to maintain our docker container. Google comes up with a technology called `kubernetes`, which if it finds a faulty container it would replace it with a new container or desired capacity of containers are not found it will create new ones.

## Integrating Kubernetes in pipeline

### Setting up Kubernetes with AWS EC2

- We need to deploy it using kubernetes and set up kubernetes cluster.
- We need an `ubuntu` server instance for this setup, this is not a part of the kubernetes cluster. This is the `k8s-management-server`
- We also need `kops` which is useful for settings up kubernetes cluster in aws.
- `aws configure` you don't need to give username or password since we've attached role so only configure the `default region`.
- We need to create an s3 bucket for keeping k8s configurations and `ssh-keygen` for logging into the k8s cluster.
- The `id_rsa.pub` will be copied onto to the kubernetes cluster. We will use the `id_rsa` key to login.
- We can edit the master of the cluster using the `kops edit ig --name=...` command. This will contain the min and max clusters.
- Install kubectl on the master node and manage the cluster from that rather than `k8s-management-server`. When logging to the `master` node from `k8s-management-server` login as an `admin` user. ie. `ssh -i ~/.ssh/id_rsa admin@xx.x..x..`  

```sh
> kubectl get nodes 
> kubectl get pods
> kubectl get deploy
> kubectl get service   
```

- Whenever we create a deploy we will create replica sets. Which will make sure that these application are available all time.
- replicas two means will create two pods
- To deploy nginx on kubernetes cluster we will run,

```sh
> kubectl run --generator=run-pod/v1 sample-nginx --image=nginx --replicas=2 --port=80 
> kubectl get deploy
> kubectl get pods -o wide
> kubectl expose deployment sample-nginx --port=80 --type=LoadBalancer # we need to create a service to expose the pods to outside
> kubectl get services -o wide
```

- Give master server ip followed by port. `http://<master_server_ip>:port` and make sure that the security group exposes that defined port.
- To remove pods

```sh
> kubectl delete pods <pod_names> # it will create new pods
```

- In real world, we create containers and pods using yaml files. If we have new deployment we delete the old pods and create new ones.

### Create deployment and service YAML files

- We will create the deployment file [valaxy-deploy.yml](notes/kubernetes/valaxy-deploy.yml)
- We will create the service file [valaxy-service.yml](notes/kubernetes/valaxy-service.yml)
- Add these two files to `k8s-management-server`.
- First we need to create a deployment and then the service.

```sh
> kubectl apply -f valaxy-deploy.yml
> kubectl get deployments
> kubectl delete deployments sample-nginx # remove previous deployments
> kubectl get services
> kubectl delete services sample-nginx
> kubectl apply -f valaxy-service.yml
> kubectl get pods -o wide
```

### Integrate Ansible Playbooks with Kubernetes

> Go through this documentation for [integrating kubernetes with ansible](notes/kubernetes/Integrating_Kubernetes_with_Ansible.MD).

- Login to ansible server and `sudo su - ansadmin`
- If we need to login to kubernetes cluster without password then we need to copy the public key to kubernetes cluster.

```sh
> cat id_rsa.pub #copy the contents
```

- Go to the `k8s-master` and under root account

```sh
> cd ~/.ssh
> ls
> cat >> authorized_keys <paste_copied_public_key>
```  

- Now, we can login from ansible server to k8s master node as root user

```sh
> ssh -i ~/.ssh/id_rsa root@<master_node_ip>
> exit
```

- Now we need to add new kubernetes group

```sh
> cd /opt
> sudo mkdir kubernetes
> cd kubernetes
> sudo vi hosts
[ansible-server]
localhost

[kubernetes]
<master_k8s_node_ip>
```

- We will create [deployment](notes/kubernetes/kubernetes-valaxy-deployment.yml) and [service](notes/kubernetes/kubernetes-valaxy-service.yml) playbooks inside `/opt/kubernetes`. In the files, hosts: `kubernetes` is the hosts group we created in hosts file. The playbook will run on the ips under this group. We need to login as `root` user so thats why the yaml file mentions `user: root`.

### Create deployment and service using Ansible

- Delete the deployment and services from the `k8s-master-node` and deploy using the jenkins server

```sh
> kubectl get deployments
> kubectl delete deployments valaxy-deployment
> kubectl get services
> kubectl delete services valaxy-services
```

- Now, go to the ansible server

```sh
> ansible-playbook -i hosts kubernetes-valaxy-deployment.yml
> ansible-playbook -i hosts kubernetes-valaxy-service.yml
```

- Now, if we go to the k8s master node we will see thats deployed successfully,

```sh
> kubectl get deployments
> kubectl get pods
> kubectl get services
> kubectl delete deployments valaxy-deployment
> kubectl get services
> kubectl delete services valaxy-services
```

### Jenkins CD Job to deploy on kubernetes

> CD job which pull the latest image and deploys

- Login to jenkins console
- New item > `deploy_on_kubernetes_cd` > `free style job`
- We just need to build with this job
- So go to `post build action` > `send build artifacts over SSH`
  - Name: `ansible-server`
  - Exec:

```sh
ansible-playbook -i /opt/kubernetes/hosts /opt/kubernetes/kubernetes-valaxy-deployment.yml;
ansible-playbook -i /opt/kubernetes/hosts /opt/kubernetes/kubernetes-valaxy-service.yml;
```

- Apply > Save
- Build now

### Jenkins CI job for creating Docker image

> CI job to build an image from the war file

- check the `hosts` file in `ansible-server` docker directory,

```sh
> cd /opt/docker
> cat hosts
localhost
<docker-host-ip>
[kubernetes]
<master_node_ip>
```
- We also need to create a new image whenever we push a new code.
- We will use `deploy_on_docker_container_using_ansible_playbooks` job which copies the war file to ansible-sever under `/opt/docker`
- We will use the same `create-simple-devops-image.yml` playbook.
- Move these files to `/opt/kubernetes` and edit the file to content of [this](notes/kubernetes/create-simple-devops-image.yml).

```sh
> cd /opt/docker
> sudo mv Dockerfile create-simple-devops-image.yml /opt/kubernetes
> cd /opt/kubernetes
> vi create-simple-devops-image.yml 
```

- Change the folder permission of `/opt/kubernetes`

```sh
> ls -ld /opt/kubernetes
> sudo chown -R ansadmin:ansadmin /opt/kubernetes
> cd /opt/kubernetes
> ls -l
```

- Now, create a new job `deploy_on_kubernetes_ci` > copy from: `deploy_on_docker_container_using_ansible_playbooks`
  - Exec command : remove the second playbook command
- Apply > Save
- Build

### Integrating Jenkins CI/CD job to deploy on k8s

### Automate deployment on k8s using Jenkins CI/CD

### Setup CI/CD Job for k8s

## License

[MIT](LICENSE) © 2021 Murshid Azher
