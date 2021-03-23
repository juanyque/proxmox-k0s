# Espera una variable en el entorno, si no, preguntará por el valor:
#   env TF_VAR_digitalocean_token
# o se puede pasar la variable en linea en la llamada:
#  TF_VAR_digitalocean_token=XXXXXXXXXXXXXXXXX terraform plan
#variable "pm_api_url" {}
#variable "pm_user" {}
#variable "pm_pass" {}

terraform {
  required_version = ">= 0.14.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
    }
  }
}

#provider "proxmox" {
#  pm_api_url = var.pm_api_url
#  pm_user = var.pm_user
#  pm_password = var.pm_pass
#  pm_tls_insecure = true
#}



resource "proxmox_vm_qemu" "generic-vm" {
  count = length(var.ips)

  name = "${var.name_prefix}-${count.index}"
  desc = "generic terraform-created vm"
  target_node = var.target_node

  clone = "ubuntu-ci"

  cores = var.cores
  sockets = 1
  memory = var.memory

  disk {
#    id = 0
    type = "scsi"
    storage = var.storage_pool
    size = var.storage_size
  }

  network {
#    id = 0
    model = "virtio"
    bridge = var.bridge
  }

  ssh_user = var.ssh_user

  os_type = "cloud-init"
  ipconfig0 = "ip=${var.ips[count.index]}/24,gw=${var.gateway}"

  sshkeys = var.sshkeys
}

