data "proxmox_virtual_environment_vms" "templates" {
  filter {
    name = "name"
    values = [local.vm_templates["${var.template_name}"]]
  }
  filter {
    name = "template"
    values = [true]
  }
}