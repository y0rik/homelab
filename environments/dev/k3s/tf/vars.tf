# mandatory
variable "pve_config" {
  type = map(string)
  sensitive = true
}
variable "tf_be_config" {
  type = map(string)
  sensitive = true
}
variable "op_token" {
  type = string
  sensitive = true
}
variable "nodes_config" {
}

# optional
variable "ansible_key_path" {
  type    = string
  default = "~/.ssh/ansible_prod.pub"
}
variable "tf_modules_path_up" {
  type = number
  default = 4
}

locals {
  tf_modules_path = "${join("",[for i in range(var.tf_modules_path_up) : "../"])}tf_modules"

  pve_host_fqdn = "${var.pve_config["host"]}.${var.pve_config["host_domain"]}"

  c_plane_instances = {
    for i in range(var.nodes_config["c_plane"].instances) : format("%s%02d", var.nodes_config["c_plane"].name, i) => "${replace(var.nodes_config["c_plane"].starting_ip, "/[0-9]{1,3}$/","")}${tonumber(split(".", var.nodes_config["c_plane"].starting_ip)[3]) + i}"
  }
  worker_instances = {
    for i in range(var.nodes_config["worker"].instances) : format("%s%02d", var.nodes_config["worker"].name, i) => "${replace(var.nodes_config["worker"].starting_ip, "/[0-9]{1,3}$/","")}${tonumber(split(".", var.nodes_config["worker"].starting_ip)[3]) + i}"
  }

  tags = [
    "env.dev",
    "svc.v_env.k3s",
  ]
}
