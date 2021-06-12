# access the previously created security group from remote state
data "terraform_remote_state" "allow_login" {
  backend = "s3"
  config = {
    bucket = "javahome-tf-1212"
    key    = "deploy-jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
