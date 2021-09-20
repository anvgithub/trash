variable "resource_group_name" {
   description = "Name of the resource group in which the resources will be created"
   default     = "Dev_Stage"
}

variable "location" {
   default = "East US"
   description = "Location where resources will be created"
}

variable "tags" {
   description = "Map of the tags to use for the resources that are deployed"
   type        = map(string)
   default = {
      environment = "dev"
   }
}

variable "application_port" {
   description = "Port that you want to expose to the external load balancer"
   default     = 80
}

variable "admin_user" {
   description = "User name to use as the admin account on the VMs that will be part of the VM scale set"
   default     = "azureuser"
}

variable "admin_password" {
   description = "Default password for admin account"
    default     = "Mimda99"
}

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}  

variable "extra_ssh_keys" {
  description = "Same as ssh_key, but allows for setting multiple public keys. Set your first key in ssh_key, and the extras here."
  type        = list(string)
  default     = []
}   

variable "ssh_key_values" {
  description = "List of Public SSH Keys values to be used for ssh access to the VMs."
  type        = list(string)
  default     = []
}

