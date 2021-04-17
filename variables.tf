variable "location" {
    type = string
    default = "westEurope"
    description = "The location all the resources will be allocated to"
}

variable "RGName" {
    type = string
    default = "weightlossRG"
    description = "Name of the resource group"
}

variable "admin_Username" {
    type = string
    description = "Admin username used to access the machine"
}

variable "admin_Password" {
    type = string
    description = "Admin password used to access the machine"
}
