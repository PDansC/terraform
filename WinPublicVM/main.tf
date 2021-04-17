resource "azurerm_public_ip" "publicip" {
  name                = var.publicIpName
  location            = var.location
  resource_group_name = var.RGName
  allocation_method   = "Static"
  sku                 = "Standard"

}

resource "azurerm_network_interface" "nic" {
  name                      = var.NICName
  location                  = var.location
  resource_group_name       = var.RGName

  ip_configuration {
    name                          = var.NICIPConfigName
    subnet_id                     = var.subnetId
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_windows_virtual_machine" "winMachine" {
  name                = var.VMName
  resource_group_name = var.RGName
  location            = var.location
  size                = var.VMSize
  admin_username      = var.admin_Username
  admin_password      = var.admin_Password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "vault" {
  network_interface_id    = azurerm_network_interface.nic.id
  ip_configuration_name   = var.NICIPConfigName
  backend_address_pool_id = var.backEndAddressPoolId
}