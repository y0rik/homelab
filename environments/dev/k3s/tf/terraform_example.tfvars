# proxmox config
pve_config = {
  user = "<user>@pam!<token_name>" # pve api token id
  password = "token_secret" # pve token secret
  host = "pve"  # pve hostname
  host_domain = "example.domain" # pve domain
  tls_insecure = true # ;(
}

# tf backend config - azure storage
tf_be_config = {
  access_key           = ""
  storage_account_name = ""
  container_name       = ""
  key                  = ""
}

# one password service user token
op_token = ""

# cluster nodes config
nodes_config = {
  c_plane = {
    cpu_cores   = 2
    memory      = 4096
    name        = "k3s-cp-" # the name will be appended with an instance number
    starting_ip = "192.168.0.10" # this is the starting IP for the role, next instances will be sequenced from this one
    instances   = 3
  }
  worker = {
    cpu_cores   = 4
    memory      = 8192
    name        = "k3s-wk-" # the name will be appended with an instance number
    starting_ip = "192.168.0.15" # this is the starting IP for the role, next instances will be sequenced from this one
    instances   = 4
  }
  common = {
    subnet_mask   = "24"
    gateway       = "192.168.0.1"
    cluster_ip    = "192.168.0.222"
    lb_range      = "192.168.0.70-192.168.0.80"
    pve_node      = "pve"
    template_name = "ubuntu"
    user_name     = "ubuntu"
    user_password = "complex_password_that_won't_be_used"
  }
}