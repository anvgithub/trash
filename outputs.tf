output "vm_ip" {
  value = ${azurerm_public_ip.lbpip.fqdn}
}

output "vm_dns" {
  value = http://${azurerm_public_ip.lbpip.fqdn}
}
