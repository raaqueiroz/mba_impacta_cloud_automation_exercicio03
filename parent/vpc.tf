resource "aws_vpc" "vpc_cloud_automation" {
  cidr_block            = var.vpc_cidr
  instance_tenancy      =   "default"
  enable_dns_support    =   true
  enable_dns_hostnames  =   true

  tags = var.tags
}

resource "aws_internet_gateway" "igw_cloud_automation" {
  vpc_id = aws_vpc.vpc_cloud_automation.id

  tags = var.tags
}

resource "aws_route_table" "rtb_pub_cloud_automation" {
  vpc_id = aws_vpc.vpc_cloud_automation.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_cloud_automation.id
      }  

  tags = var.tags
}

resource "aws_subnet" "subnet_cloud_automation" {
  vpc_id                = aws_vpc.vpc_cloud_automation.id
  cidr_block            = var.subnet_cidr
  availability_zone_id     = data.aws_availability_zones.az1a.zone_ids[0]

  tags = var.tags
}

resource "aws_route_table_association" "rtb_association_cloud_automation" {
  subnet_id      = aws_subnet.subnet_cloud_automation.id
  route_table_id = aws_route_table.rtb_pub_cloud_automation.id
}

resource "aws_security_group" "sg_cloud_automation" {
  name        = "${var.name}-SGCloudAutomation"
  description = "SGCloudAutomation"
  vpc_id      = aws_vpc.vpc_cloud_automation.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Jenkins Port"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Same VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}