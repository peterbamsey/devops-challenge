output "ec2-public-ip" {
  description = "The public IP address of the ec2 instance"
  value       = "${module.ec2.public_ip}"
}
