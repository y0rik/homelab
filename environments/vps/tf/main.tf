resource "hcloud_primary_ip" "ip" {
  name          = "${var.server_config["name"]}-ip"
  datacenter    = var.server_config["datacenter"]
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
  labels = local.tags
}

resource "hcloud_server" "server" {
  name        = var.server_config["name"]
  image       = var.server_config["image"]
  server_type = var.server_config["server_type"]
  datacenter  = var.server_config["datacenter"]

  user_data = templatefile("templates/cloud-init.yml", {
      host_username = var.server_config["user"]
      host_ssh_port = var.server_config["ssh_port"]
      host_ssh_key  = data.onepassword_item.ssh_key.public_key
    })
  
  firewall_ids = [hcloud_firewall.fw.id]

  public_net {
    ipv4_enabled = true
    ipv4 = hcloud_primary_ip.ip.id
    ipv6_enabled = false
  }

  labels = local.tags
}

resource "hcloud_firewall" "fw" {
  name = "${var.server_config["name"]}-fw"
  labels = local.tags
  
  # create rules based on server config
  dynamic "rule" {
    for_each = split(",", var.server_config["allowed_incoming_ip_ports"])
    content {
      direction = "in"
      protocol  = "tcp"
      port      = rule.value
      source_ips = ["0.0.0.0/0"]
    }
  }
}