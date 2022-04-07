output "slacko-app-IP" {
  value = aws_instance.jenkins_ec2.public_ip
}

output "vpc_id" {
 value = aws_vpc.vpc_cloud_automation.id
}

output "subnet_id" {
 value = aws_subnet.subnet_cloud_automation.id
}

output "sg_id" {
 value = aws_security_group.sg_cloud_automation.id
}