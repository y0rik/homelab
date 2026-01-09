# required
variable "vm_name" {
  type = string
}
variable "template_name" {
  type = string
}
variable "ip_address" {
  type = string
}
variable "subnet_mask" {
  type = string
}
variable "gateway" {
  type = string
}
variable "pve_node" {
  type = string
}
variable "tags" {
  type = list(string)
}
variable "user_name" {
  type = string
}
variable "user_password" {
  type = string
}

# optional
variable "cores" {
  type = number
  default = 1
}
variable "memory" {
  type = number
  default = 2048
}
variable "disk" {
  type = string
  default = "30"
}
variable "storage" {
  type = string
  default = "guests"
}

variable "onboot" {
  type = bool
  default = true
}
variable "protection" {
  type = bool
  default = false
}
variable "template_fullclone" {
  type = bool
  default = true
}

locals {
  vm_templates = {
    "ubuntu"  = "ubuntu-cloud-noble"
    "rocky"   = "rockylinux-cloud-10"
  }
}