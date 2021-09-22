output "vm_ip" {
  value = azurerm_public_ip.lbpip.fqdn
}

