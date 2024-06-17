output "node-ips" {
  # value = flatten(module.rke2_clusters[*].instances_public_ip)
  value = local.node_name_ip
}

output "node-files" {
  value = local.node_name_key
}

output "ssh-username" {
  value = tostring(module.rke2_clusters[0].node_username)
}