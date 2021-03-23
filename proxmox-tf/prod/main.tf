# Espera una variable en el entorno, si no, preguntará por el valor:
#   env TF_VAR_digitalocean_token
# o se puede pasar la variable en linea en la llamada:
#  TF_VAR_digitalocean_token=XXXXXXXXXXXXXXXXX terraform plan
variable "pm_api_url" {}
variable "pm_user" {}
variable "pm_pass" {}

terraform {
  required_version = ">= 0.14.0"

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.pm_api_url
  pm_user = var.pm_user
  pm_password = var.pm_pass
  pm_tls_insecure = true
}

module "k0s-cluster" {
  source = "../modules/generic-cluster"

  name_prefix = "k0s-node"
  ips = [
    "192.168.0.201",
    "192.168.0.202",
    "192.168.0.203",
    "192.168.0.204",
  ]

  sshkeys = <<EOF
ssh-ed25519 ASDASDSADgsfdlgjkhfsdlgjhsfldgkhfdsjkghkfdjlsghlkfsdghkjsdhfkgsdhfkljghkjsdf ansible
EOF

  gateway = "192.168.0.1"
  bridge = "vmbr0"
  storage_size = "32G"
  storage_pool = "local-zfs"
  target_node = "pve1"
}

