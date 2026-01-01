# 1pass token
variable "op_token" {
  type      = string
  sensitive = true
}

# hcloud token data
variable "op_hcloud_vault" {
  type = string
}
variable "op_hcloud_id" {
  type = string
}

variable "tf_be_config" {
  type = map(string)
}

# server data
variable "server_config" {
  type = map(string)
}

# ssh public key id for the server
variable "op_ssh_key_id" {
  type = string
}

# dns-related vars
variable "dns_zone_name" {
  type = string
}
variable "dns_zone_ttl" {
  type = string
}

# locals
locals {
  tags = {
    env = "prod"
    svc = "vps"
  }
}