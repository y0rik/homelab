# ansible configuration
resource "local_file" "ansible_inventory" {
  content = "[vps]\n${hcloud_primary_ip.ip.ip_address}"
  filename = "../ansible/inventory/hosts.ini"
}
resource "local_file" "ansible_config" {
  content = templatefile("templates/ansible.cfg", {
    host_user = var.server_config["user"]
    host_port = var.server_config["ssh_port"]
  })
  filename = "../ansible/ansible.cfg"
}