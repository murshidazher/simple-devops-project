# simple-devops-project
a simple devops project with the use of Jenkins | Ansible | Docker | Kubernetes

## 1. Setup CI/CD with Jenkins, Git, Maven and Tomcat

- Setup Jenkins
- Run a test job
- Setup & configure Maven and Git
- Setup Tomcat Server
- Installing addtional required plugins
- Integrating Git, Mavan in Jenkins job
- Run CI/CD job

<img src="./docs/1.png"/>

### 2. Introducing Docker

- Setting up Docker environment
- Managing Docker with Ansible
- DockerHub repository
- Writing a Docker file
- Run a job

<img src="./docs/2.png"/>

### 3. Integration with Ansible

- Setting up Ansible environment
- Integrating Ansible with Jenkins
- Writing a Ansible playbook to deploy on container
- Run a job

<img src="./docs/3.png"/>

### 4. Introducing Kubernetes

- Setting up Kubernetes environment
- Write deployment and service files
- Run a job

<img src="./docs/4.png"/>

## What is CI/CD ?

- Continuos Integration (CI)
- Continuos Delivery (CD) - There will be a manual intervention to deploy to env
- Continuos Deployment (CD) - No manual intervention
- CI process with result in an artifact which is used in the staging env.

<img src="./docs/5.png"/>

- If this whole process happens without any manual intervention then its continuos deployment.
  
<img src="./docs/6.png"/>
<img src="./docs/7.png"/>

## Jenkins Installation

> The whole documentation for installation can be found [here](jenkins/01.jenkins_installation.MD)

- Go into aws console and create an EC2 instance
