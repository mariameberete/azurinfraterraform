variable "rg-resource_group" {
    type = string
    description = "Name for the ressource group"
}

variable "vnet" {
    type= list(string)
    description = "vnet description"
}

variable "subnet" {
    type= list(string)
    description = "subnet description"
}
variable "open_ports"{
    type= list(string)
}