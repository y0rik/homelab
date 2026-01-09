terraform {
  required_providers {
    proxmox = {
      source  = "registry.terraform.io/bpg/proxmox"
      version = "~> 0.90"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 3.0"
    }
    null = {}
  }
  
  /*
  backend "azurerm" {
    access_key           = var.tf_be_config["access_key"]
    storage_account_name = var.tf_be_config["storage_account_name"]
    container_name       = var.tf_be_config["container_name"]
    key                  = var.tf_be_config["key"]
  }
  */
}

provider "proxmox" {
  alias     = "main"
  endpoint  = "https://${local.pve_host_fqdn}:8006/"
  api_token = "${var.pve_config["user"]}=${var.pve_config["password"]}"
  insecure = var.pve_config["tls_insecure"]
  ssh {
    agent     = true
    username  = "root"
  }
}

# 1pass provider
provider "onepassword" {
  service_account_token = var.op_token
}