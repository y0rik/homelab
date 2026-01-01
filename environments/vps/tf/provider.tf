terraform {
  required_version = "~> 1.10"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    access_key           = var.tf_be_config["access_key"]
    storage_account_name = var.tf_be_config["storage_account_name"]
    container_name       = var.tf_be_config["container_name"]
    key                  = var.tf_be_config["key"]
  }
}

# 1pass provider
provider "onepassword" {
  service_account_token = var.op_token
}

# Hetzner Cloud Provider
provider "hcloud" {
  token = data.onepassword_item.hcloud_token.password
}

