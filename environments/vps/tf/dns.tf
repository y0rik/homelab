resource "hcloud_zone" "zone" {
  name = var.dns_zone_name
  mode = "primary"
  ttl = var.dns_zone_ttl
  labels = local.tags
  delete_protection = false
}

resource "hcloud_zone_rrset" "root_a" {
  records = [
    { value = hcloud_primary_ip.ip.ip_address, comment = hcloud_server.server.name },
  ]
  name = "@"
  type = "A"

  zone = hcloud_zone.zone.name

  labels = local.tags
  change_protection = false
}