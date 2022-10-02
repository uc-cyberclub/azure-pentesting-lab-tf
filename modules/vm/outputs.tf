output "web-public-ip" {
    value = azurerm_linux_virtual_machine.web.public_ip_address
}

output "username" {
    value = azurerm_linux_virtual_machine.web.admin_username
}

