module "slackoapp" {
    source          = "../parent/"
    vpc_cidr        = "172.23.0.0/16"
    subnet_cidr     = "172.23.0.0/24"
    ec2_type        = "t3a.small"
    name            = "Slacko"
    
    tags = {
        "Name" = "Slacko"
        "Atividade" = "Exercicio03"
    }    
}