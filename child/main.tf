module "slackoapp" {
    source          = "../parent/"
    vpc_cidr        = var.vpc_cidr
    subnet_cidr     = var.subnet_cidr
    ec2_type        = var.ec2_type
    name            = var.name
    tags            = var.tags
}