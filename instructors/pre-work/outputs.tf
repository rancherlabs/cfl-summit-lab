output "rancher-node-ip" {
  value = local.rancher-node-ip
}

output "rancher-node-key" {
  value = local.rancher-node-key
}

output "downstream-node-ips" {
  value = local.downstream-node-ips
}

output "downstream-node-keys" {
  value = local.downstream-node-keys
}

output "ssh-username" {
  value = tostring(module.rancher_rke2_cluster.node_username)
}