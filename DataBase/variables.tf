variable "RGName" {
    type = string
    description = "Name of resource Group"
}

variable "location" {
    type = string
    description = "The location all the resources will be allocated to"
}

variable "admin_Username" {
    type = string
    description = "Admin username used to access the machine"
}

variable "admin_Password" {
    type = string
    description = "Admin password used to access the machine"
}

variable "privateSubnetId" {
    type = string
    description = "Id of private subnet"
}