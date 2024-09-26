variable "attendees" {
  type        = number
  description = "The number of attendees (rke2 single node clusters) to prepare"
  default     = null # required
}

variable "prefix" {
  type        = string
  description = "A prefix for all resources created"
  default     = "cfl-lab"

}

variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
  default     = null
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
  default     = null
}

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-west-2"

  validation {
    condition = contains([
      "us-east-2",
      "us-east-1",
      "us-west-1",
      "us-west-2",
      "af-south-1",
      "ap-east-1",
      "ap-south-2",
      "ap-southeast-3",
      "ap-southeast-4",
      "ap-south-1",
      "ap-northeast-3",
      "ap-northeast-2",
      "ap-southeast-1",
      "ap-southeast-2",
      "ap-northeast-1",
      "ca-central-1",
      "ca-west-1",
      "eu-central-1",
      "eu-west-1",
      "eu-west-2",
      "eu-south-1",
      "eu-west-3",
      "eu-south-2",
      "eu-north-1",
      "eu-central-2",
      "il-central-1",
      "me-south-1",
      "me-central-1",
      "sa-east-1",
    ], var.aws_region)
    error_message = "Invalid Region specified!"
  }
}

variable "rancher_instance_type" {
  description = "EC2 instance type to use for the Rancher local cluster"
  default = "t3a.large"
}

variable "rancher_password" {
  description = "Password used to bootstrap Rancher and the admin password to access Rancher"
  default = "initial-admin-password"
}

variable "downstream_instance_type" {
  description = "EC2 instance type to use for the downstream clusters"
  default = "t3a.medium"
}

variable "spot_instances" {
  default = false
}