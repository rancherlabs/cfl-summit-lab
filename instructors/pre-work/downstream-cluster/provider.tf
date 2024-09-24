provider "rancher2" {
  api_url = "https://${module.rke2-server.public_address}.nip.io"
  bootstrap = true
}
