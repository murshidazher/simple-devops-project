# Variables TF File
variable "region" {
  description = "AWS Region"
}

variable "ami_id" {
  description = "AMI ID to be used for Instance"
}

variable "instancetype" {
  description = "Instance Type to be used for Instance"
}

variable "subnetid" {
  description = "Subnet ID to be used for Instance"
}

variable "AppName" {
  description = "Application Name"
  default     = "jenkins-server"
}

variable "Env" {
  description = "Application Name"
}

variable "HostIp" {
  description = " Host IP to be allowed SSH for"
}

variable "PvtIp" {
  description = " Host IP to be allowed SSH for"
}
