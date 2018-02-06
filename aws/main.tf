# Providers
provider "aws" {
  version     = "v1.1.0"
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.region}"
}

# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "test"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "test"
  }
}

# Filter for the latest AWS AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

# Security Group
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ssh from anywhere"
  description = "Security group for inbound ssh anywhere"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = {
    Terraform = "true"
    Environment = "test"
  }
}

# EC2 instance
module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "test"
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "t2.micro"
  subnet_id                   = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids      = ["${module.security_group.this_security_group_id}"]
  associate_public_ip_address = true
  # See https://github.com/hashicorp/terraform/issues/145
  user_data                   = "${base64encode(file("${path.module}/userdata.yml"))}"

  tags = {
    Terraform = "true"
    Environment = "test"
  }

}
