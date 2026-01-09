# control plane
module "c_plane_vms" {
  source = "${local.tf_modules_path}/pve_vm"
  providers = {
    proxmox = proxmox.main
  }
  for_each = tomap(local.c_plane_instances)

  cores = var.nodes_config["c_plane"].cpu_cores
  memory = var.nodes_config["c_plane"].memory
  vm_name = each.key
  ip_address = each.value

  template_name = var.nodes_config["common"].template_name
  
  subnet_mask = var.nodes_config["common"].subnet_mask
  gateway = var.nodes_config["common"].gateway
  pve_node = var.nodes_config["common"].pve_node

  user_name = var.nodes_config["common"].user_name
  user_password = var.nodes_config["common"].user_password

  tags = local.tags
}

# workers
module "worker_vms" {
  source = "${local.tf_modules_path}/pve_vm"
  providers = {
    proxmox = proxmox.main
  }
  for_each = tomap(local.worker_instances)

  cores = var.nodes_config["worker"].cpu_cores
  memory = var.nodes_config["worker"].memory
  vm_name = each.key
  ip_address = each.value

  template_name = var.nodes_config["common"].template_name
  
  subnet_mask = var.nodes_config["common"].subnet_mask
  gateway = var.nodes_config["common"].gateway
  pve_node = var.nodes_config["common"].pve_node

  user_name = var.nodes_config["common"].user_name
  user_password = var.nodes_config["common"].user_password

  tags = local.tags
}