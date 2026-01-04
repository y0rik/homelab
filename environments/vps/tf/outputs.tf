output "host_connection_string_byip" {
  value = "ssh ${var.server_config["user"]}@${hcloud_primary_ip.ip.ip_address} -p ${var.server_config["ssh_port"]}"
}

output "host_connection_string_byname" {
  value = "ssh ${var.server_config["user"]}@${hcloud_zone.zone.name} -p ${var.server_config["ssh_port"]}"
}