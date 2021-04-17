variable "publicIpName" {
    type = string
    description = "Name of public ip"
}

variable "location" {
    type = string
    description = "The location all the resources will be allocated to"
}

variable "RGName" {
    type = string
    description = "Name of the resource group"
}

variable "NICName" {
    type = string
    description = "Name of network interface configuration"
}

variable "NICIPConfigName" {
    type = string
    description = "Name op network interface ip configuration"
}

variable "subnetId" {
    type = string
    description = "Id of the subnet"
}

variable "VMName" {
    type = string
    description = "Name of the virtual machine"
}

variable "VMSize" {
    type = string
    description = "Size of the virtual machine"
}

variable "admin_Username" {
    type = string
    description = "Admin username used to access the machine"
}

variable "admin_Password" {
    type = string
    description = "Admin password used to access the machine"
}

variable "backEndAddressPoolId" {
    type = string
    description = "Id of backend address pool"
}

