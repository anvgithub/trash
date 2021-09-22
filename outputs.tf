#output "vmss_public_ip_fqdn" {
  # value = azurerm_public_ip.vmss.fqdn
#}

  # sh """
                        export vmss_ip=${terraform output vm_ip}
                        #echo "host1 ansible_ssh_port=50001 ansible_ssh_host=$vmss_ip" > /home/anv/inventory
                        #echo "host2 ansible_ssh_port=50002 ansible_ssh_host=$vmss_ip" >> home/anv/inventory
                        #cat inventory
                       # """
