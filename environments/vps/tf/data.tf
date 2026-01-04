# get hcloud access token
data "onepassword_item" "hcloud_token" {
  vault = var.op_hcloud_vault
  title = var.op_hcloud_id
}

# pub ssh key
data "onepassword_item" "ssh_key" {
  vault = var.op_hcloud_vault
  title = var.op_ssh_key_id
}
