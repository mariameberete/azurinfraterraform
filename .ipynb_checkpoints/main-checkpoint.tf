module "projectGithub"{
source = "./modules/network"
rg-resource_group = "rg-${var.name}"
vnet = ["10.0.0.0/16"]
subnet = ["10.0.1.0/24"]
open_ports = ["80","443"]
}