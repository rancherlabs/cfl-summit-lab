output "rancher-node-ips" {
  value = local.rancher-node-ips
}

output "rancher-node-keys" {
  value = local.rancher-node-keys
}

output "downstream-node-ips" {
  value = local.downstream-node-ips
}

output "downstream-node-keys" {
  value = local.downstream-node-keys
}

output "ssh-username" {
  value = tostring(module.rancher_rke2_clusters[0].node_username)
}