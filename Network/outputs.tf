output "publicSubnetId" {
    value = azurerm_subnet.publicSubnet.id
}

output "privateSubnetId" {
    value = azurerm_subnet.privateSubnet.id
}

output "addressPoolId" {
    value = azurerm_lb_backend_address_pool.LBBackendAddressPool.id
}