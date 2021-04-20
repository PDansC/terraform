resource "azurerm_virtual_network" "vnet" {
    name                = var.VnetName
    address_space       = [var.CIDR]
    location            = var.location
    resource_group_name = var.RGName
}

resource "azurerm_subnet" "publicSubnet" {
  name                 = var.publicSubnetName
  resource_group_name  = var.RGName
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.publicSubnetRange]
}

resource "azurerm_subnet" "privateSubnet" {
  name                                           = var.privateSubnetName
  resource_group_name                            = var.RGName
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [var.privateSubnetRange]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_network_security_group" "nsg" { 
  name                = var.NSGName
  location            = var.location
  resource_group_name = var.RGName

  security_rule {
    name                       = "RDP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = var.publicSubnetRange
  }
    security_rule {
    name                       = "OpenPort8080"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = var.publicSubnetRange
  }
  security_rule {
    name                       = "OpenPort5432"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = var.publicSubnetRange
    destination_address_prefix = var.privateSubnetRange
  }
}

resource "azurerm_subnet_network_security_group_association" "publicSubnet" {
  subnet_id                 = azurerm_subnet.publicSubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "privateSubnet" {
  subnet_id                 = azurerm_subnet.privateSubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "publicIp" {
  name                 = var.LBPublicIpName
  location             = var.location
  resource_group_name  = var.RGName
  allocation_method    = "Static"
  sku                  = "Standard"
}

resource "azurerm_lb" "PublicLoadBalancer" {
  name                 = var.LBName
  location             = var.location
  resource_group_name  = var.RGName
  sku                  = "Standard"
  frontend_ip_configuration {
    name                 = var.IPConfigName
    public_ip_address_id = azurerm_public_ip.publicIp.id    
  }
}

resource "azurerm_lb_rule" "LBOpenPort8080" {
  resource_group_name            = var.RGName
  loadbalancer_id                = azurerm_lb.PublicLoadBalancer.id
  name                           = "LBRulePort8080"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = var.IPConfigName
  backend_address_pool_id        = azurerm_lb_backend_address_pool.LBBackendAddressPool.id
}

resource "azurerm_lb_backend_address_pool" "LBBackendAddressPool" {
  loadbalancer_id      = azurerm_lb.PublicLoadBalancer.id
  name                 = "LBBackEndAddressPool"
}

