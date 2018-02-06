## AWS:

- Tested against Terraform v0.11.3

This terraform module will:
    - A new VPC (don't use default VPC)
    - A public subnet.
    - A security group that allows only SSH in from everywhere.
    - A t2.micro instance launched in the public subnet with an ssh user:
        - User: thirdbridge
        - Password: 123456

- Example usage:
`terraform init`
`terraform plan`
`terraform apply`

- Outputs
  - ec2-public-ip: The public IP address of the new EC2 instance
