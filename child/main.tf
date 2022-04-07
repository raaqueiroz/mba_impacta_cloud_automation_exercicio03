module "jenkins" {
    source                      = "../parent/"
    vpc_cidr                    = "172.23.0.0/16"
    subnet_cloud_automation     = "172.23.0.0/24"
    ec2_type                    = "t3a.small"
    
    tags = {
        "Name" = "Jenkins"
        "Atividade" = "Exercicio02"
    }    
}