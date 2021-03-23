resource "proxmox_vm_qemu" "generic-vm" {
  count = length(var.ips)

  name = "${var.node_name}"
  desc = "generic terraform-created vm"
  target_node = "pve1"

  clone = "ubuntu-ci"

  cores = 2
  sockets = 1
  memory = 2048

	disk {
		id = 0
		type = "scsi"
		storage = "local-zfs"
		size = "32G"
	}

  network {
    id = 0
    model = "virtio"
    bridge = "vmbr0"
  }

  ssh_user = "ubuntu"

  os_type = "cloud-init"
  ipconfig0 = "ip=${var.main_ip}/24,gw=192.168.0.1"

  sshkeys = <<EOF
ssh-ed25519 ASDASDSADgsfdlgjkhfsdlgjhsfldgkhfdsjkghkfdjlsghlkfsdghkjsdhfkgsdhfkljghkjsdf ansible
EOF
}
