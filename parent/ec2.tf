resource "aws_key_pair" "slacko-key-ssh" {
 key_name = "slacko-ssh-key"
 public_key = var.public_key
}

resource "aws_instance" "slacko-app" {
  ami = data.aws_ami.slacko-amazon.id
  instance_type = var.ec2_type
  subnet_id = aws_subnet.subnet_cloud_automation.id
  associate_public_ip_address = true
  key_name = aws_key_pair.slacko-key-ssh.key_name
  user_data = file("ec2.sh")
  security_groups = [aws_security_group.sg_cloud_automation.id]
  
  tags = var.tags
}

resource "aws_instance" "slacko-mongodb" {
  ami = data.aws_ami.slacko-amazon.id
  instance_type = var.ec2_type
  subnet_id = aws_subnet.subnet_cloud_automation.id
  associate_public_ip_address = true
  key_name = aws_key_pair.slacko-key-ssh.key_name
  user_data = file("mongodb.sh")
  security_groups = [aws_security_group.sg_cloud_automation.id]
  
  tags = var.tags 
}