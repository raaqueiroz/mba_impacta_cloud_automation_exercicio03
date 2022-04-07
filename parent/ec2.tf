resource "aws_key_pair" "jenkins_key_pair" {
 key_name = "jenkins_key_pair"
 public_key = var.public_key
}

resource "aws_instance" "jenkins_ec2" {
  ami = data.aws_ami.ubuntu20.id
  instance_type = var.ec2_type
  subnet_id = aws_subnet.subnet_cloud_automation.id
  associate_public_ip_address = true
  key_name = aws_key_pair.jenkins_key_pair.key_name
  user_data = file("jenkins.sh")
  security_groups = [aws_security_group.sg_cloud_automation.id]

  provisioner "remote-exec" {
    inline = [
      "sleep 180",
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword",
    ]
  }

  connection {
		type        = "ssh"
		user        = "ubuntu"
		private_key = file("exercicio02.pem")
		host        = aws_instance.jenkins_ec2.public_ip
	}
  
  tags = var.tags
}