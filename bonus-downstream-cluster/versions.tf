terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.13.1"
    }

    rancher2 = {
      source  = "rancher/rancher2"
      version = ">= 3.0.0"
    }
  }
}