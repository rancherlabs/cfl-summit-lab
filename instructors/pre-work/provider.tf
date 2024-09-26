provider "aws" {
  access_key = var.aws_access_key != null ? var.aws_access_key : null
  secret_key = var.aws_secret_key != null ? var.aws_secret_key : null
  region     = var.aws_region
}

terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "5.0.0"
    }
  }
}

provider "rancher2" {
  alias = "bootstrap"
  api_url = "https://${module.rancher_rke2_cluster.instances_public_ip[0]}.nip.io"
  bootstrap = true
  insecure = true
  timeout = "600s"
}

provider "rancher2" {
  alias = "admin"
  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
  insecure = true
}