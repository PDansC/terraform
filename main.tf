terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.RGName
  location = var.location
}

module "Network" {
    source = "./Network"
    VnetName                    = "weightlossVnet"
    CIDR                        = "10.0.0.0/16"
    RGName                      = azurerm_resource_group.rg.name
    location                    = azurerm_resource_group.rg.location
    publicSubnetName            = "public"
    publicSubnetRange           = "10.0.0.0/24"
    privateSubnetName           = "private"
    privateSubnetRange          = "10.0.1.0/24"
    NSGName                     = "weightlossNSG"
    LBPublicIpName                = "PublicIPForLB"
    LBName                        = "PublicLoadBalancer"
    IPConfigName                  = "PublicIPAddressConfig"
}

module "VirtualMachine1" {
  source = "./WinPublicVM"
  publicIpName                  = "WLServer"
  RGName                        = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  NICName                       = "WLServer1NIC"
  NICIPConfigName               = "WLServer1NICIPConfig"
  subnetId                      = module.Network.publicSubnetId
  VMName                        = "WLSVM1"
  VMSize                        = "Standard_B2s"
  admin_Password                = var.admin_Password
  admin_Username                = var.admin_Username
  backEndAddressPoolId          = module.Network.addressPoolId
}

module "VirtualMachine2" {
  source = "./WinPublicVM"
  publicIpName                  = "WLServer2"
  RGName                        = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  NICName                       = "WLServer2NIC"
  NICIPConfigName               = "WLServer2NICIPConfig"
  subnetId                      = module.Network.publicSubnetId
  VMName                        = "WLSVM2"
  VMSize                        = "Standard_B2s"
  admin_Password                = var.admin_Password
  admin_Username                = var.admin_Username
  backEndAddressPoolId          = module.Network.addressPoolId
}

module "VirtualMachine3" {
  source = "./WinPublicVM"
  publicIpName                  = "WLServer3"
  RGName                        = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  NICName                       = "WLServer3NIC"
  NICIPConfigName               = "WLServer3NICIPConfig"
  subnetId                      = module.Network.publicSubnetId
  VMName                        = "WLSVM3"
  VMSize                        = "Standard_B2s"
  admin_Password                = var.admin_Password
  admin_Username                = var.admin_Username
  backEndAddressPoolId          = module.Network.addressPoolId
}

module "Postgresql" {
  source = "./DataBase"
  RGName                        = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  admin_Password                = var.admin_Password
  admin_Username                = var.admin_Username
  privateSubnetId               = module.Network.privateSubnetId
  }