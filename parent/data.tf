data "aws_availability_zones" "az1a" {
   filter {
     name = "zone-name"
     values = ["us-east-1a"]
   }
}

data "aws_ami" "ubuntu20" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}