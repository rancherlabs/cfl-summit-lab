module "rke2_clusters" {
  count               = var.attendees
  source              = "../aws-rke2-module"
  aws_region          = var.aws_region
  prefix              = "${var.prefix}-${count.index + 1}"
  instance_count      = 1
  create_ssh_key_pair = true
  # spot_instances      = true # only while testing 
  user_data           = <<-END
    #!/bin/sh

    PUBLIC_IP=$(curl ifconfig.io)

    # The below when commented will use the latest stable RKE2 channel/version
    # export INSTALL_RKE2_VERSION="v1.20.5+rke2r1"

    curl -sfL https://get.rke2.io | sh -
    mkdir -p /etc/rancher/rke2
    cat > /etc/rancher/rke2/config.yaml <<EOF
    write-kubeconfig-mode: "0640"
    tls-san:
      - "$${PUBLIC_IP}"
      - "$${PUBLIC_IP}.nip.io"
    EOF

    systemctl enable rke2-server
    systemctl start rke2-server

    cat >> /etc/profile <<EOF
    export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
    export CRI_CONFIG_FILE=/var/lib/rancher/rke2/agent/etc/crictl.yaml
    PATH="$PATH:/var/lib/rancher/rke2/bin"
    alias k=kubectl
    EOF

    # Install helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  END
}

locals {
  node_name_ip = [for i, v in flatten(module.rke2_clusters[*].instances_public_ip) : "${var.prefix}-${i+1}: ${v}"]

  node_name_key = [for i, v in module.rke2_clusters[*].ssh_key_path : "${var.prefix}-${i+1}: ${basename(v)}"]
}