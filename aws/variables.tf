# AWS access keys - these need to be passed to terraform as env vars or
# by using a tfvars key/value file and calling terraform with --var-file
# i.e. terraform plan -var-file=/path/outside/repo/terraform.tfvars
variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  #ireland
  default     = "eu-west-1"
}
