resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.vm_name
  description = "managed by terraform, see tags for details"
  node_name   = var.pve_node
  on_boot     = var.onboot
  protection  = var.protection
  started     = true
  
  tags        = var.tags

  clone {
    vm_id = element(data.proxmox_virtual_environment_vms.templates.vms, 0).vm_id
    full  = var.template_fullclone
  }
  cpu {
    cores        = var.cores
    type         = "x86-64-v3" # supports both Ryzen Zen3 & Intel Xeon 6gen
  }
  memory {
    dedicated = var.memory
    floating  = var.memory_balooning ? var.memory : 0 # set to memory if balooning is enabled
  }
  disk {
    datastore_id = var.storage
    size         = var.disk
    interface    = "scsi0"
    ssd          = "true"
    discard      = "on"
  }
  network_device {
    bridge = "vmbr0"
    model   = "virtio"
  }
  operating_system {
    type = "l26"
  }
  agent {
    enabled = true
  }
  startup {
    order      = "3"
    up_delay   = "60"
    down_delay = "60"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${var.ip_address}/${var.subnet_mask}"
        gateway = var.gateway
      }
    }
    dns {
      servers = [var.gateway]
    }
    user_account {
      username = var.user_name
      password = var.user_password
    }
    datastore_id = var.storage
    
  }

}
