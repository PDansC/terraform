variable "VnetName" {
    type = string
    description = "Name of the virtual network"
}

variable "CIDR" {
    type = string
    description = "Address Range of the virtual network"
}

variable "RGName" {
    type = string
    description = "Name of resource Group"
}

variable "location" {
    type = string
    description = "The location all the resources will be allocated to"
}

variable "publicSubnetName"{
    type = string
    default = "public"
    description = "Name of public subnet"
}

variable "publicSubnetRange" {
    type = string
    description = "Address Range of the public subnet"
}

variable "privateSubnetName"{
    type = string
    description = "Name of private subnet"
}

variable "privateSubnetRange" {
    type = string
    description = "Address Range of the private subnet"
}

variable "NSGName" {
    type = string
    description = "Name of network security group"
}

variable "LBPublicIpName" {
    type = string
    description = "Name of public loadbalancer ip" 
}

variable "LBName" {
    type = string   
    description = "Name of load balancer"
}

variable "IPConfigName" {
    type = string
    description = "Name of ip configuration"
}
