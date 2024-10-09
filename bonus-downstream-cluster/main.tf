module "downstream_rke2" {
  depends_on = [aws_security_group.sg_allowall]
  source = "github.com/rancher/tf-rancher-up/modules/downstream/aws/v2"

  aws_access_key      = var.aws_access_key
  aws_secret_key      = var.aws_secret_key
  cloud_credential_id = var.cloud_credential_id
  aws_region          = var.aws_region
  vpc_id              = var.vpc_id
  zone                = var.zone
  subnet_id           = var.subnet_id
  security_group_name = "${var.cluster_name}-allow-nodes"
  ssh_user            = var.ssh_user
  ami                 = var.ami != null ? var.ami : data.aws_ami.suse.id
  instance_type       = var.instance_type
  volume_size         = var.volume_sizeg
  spot_instances      = var.spot_instances

  cluster_name          = var.cluster_name
  kubernetes_version    = var.kubernetes_version
  worker_node_pool_name = var.worker_node_pool_name
  cp_node_pool_name     = var.cp_node_pool_name
  cp_count              = var.cp_count
  worker_count          = var.worker_count
  cni_provider          = var.cni_provider
}

resource "aws_security_group" "sg_allowall" {
  vpc_id = var.vpc_id

  name        = "${var.cluster_name}-allow-nodes"
  description = "${var.cluster_name} - Allow traffic for nodes in the cluster"

  ingress {
    description = "Allow all inbound from nodes in the cluster"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  ingress {
    description = "Allow all inbound SSH to nodes"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all inbound kube-apiserver to nodes"
    from_port   = "6443"
    to_port     = "6443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all inbound HTTPS to nodes"
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "cfl-lab"
  }
}