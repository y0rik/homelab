locals {
  k8s_template_file = templatefile("./templates/k8s.tpl", {
    k3s_master_ip = "${join("\n", [for name, ip in local.c_plane_instances : ip])}",
    k3s_node_ip   = "${join("\n", [for name, ip in local.worker_instances : ip])}"
  })
}

resource "local_file" "k8s_file" {
  content  = local.k8s_template_file
  filename = "../ansible/inventory/my-cluster/hosts.ini"
}

resource "null_resource" "update_var_file" {

  provisioner "local-exec" {
    command = <<-EOT
      # generate k8s cluster password
      password=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 30)
      # get config
      cat ../ansible/inventory/example/group_vars/all.yml | \
      # set nodes username
      sed -E "s/^ansible_user:.*$/ansible_user: ${var.nodes_config["common"].user_name}/g" | \
      # set k8s password
      sed -E "s/^k3s_token:.*$/k3s_token: $password/g" | \
      # set cluster ip
      sed -E "s/^apiserver_endpoint:.*$/apiserver_endpoint: ${var.nodes_config["common"].cluster_ip}/g" | \
      # set loadbalancer range
      sed -E "s/^metal_lb_ip_range:.*$/metal_lb_ip_range: ${var.nodes_config["common"].lb_range}/g" > ../ansible/inventory/my-cluster/group_vars/all.yml
    EOT
  }
}
