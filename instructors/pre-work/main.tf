module "rancher_rke2_cluster" {
  source              = "./aws-rke2-module"
  aws_region          = var.aws_region
  prefix              = "${var.prefix}-rancher-cluster"
  instance_count      = 1
  create_ssh_key_pair = true
  instance_type = var.rancher_instance_type
  spot_instances      = var.spot_instances
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
    
    mkdir -p /var/lib/rancher/rke2/server/manifests/
    
    cat > /var/lib/rancher/rke2/server/manifests/cert-manager.yaml << EOF
    apiVersion: helm.cattle.io/v1
    kind: HelmChart
    metadata:
      name: cert-manager
      namespace: kube-system
    spec:
      createNamespace: true
      targetNamespace: cert-manager
      repo: https://charts.jetstack.io
      chart: cert-manager
      version: v1.15.3
      set:
        crds.enabled: "true"
      helmVersion: v3
    EOF

    cat > /var/lib/rancher/rke2/server/manifests/rancher.yaml << EOF
    apiVersion: v1
    kind: Namespace
    metadata:
      name: cattle-system
    ---
    apiVersion: helm.cattle.io/v1
    kind: HelmChart
    metadata:
      name: rancher
      namespace: kube-system
    spec:
      targetNamespace: cattle-system
      repo: https://charts.rancher.com/server-charts/prime
      chart: rancher
      set:
        hostname: $PUBLIC_IP.nip.io
        replicas: 1
        bootstrapPassword: ${var.rancher_password}
      helmVersion: v3
    EOF

    cat > /var/lib/rancher/rke2/server/manifests/lab-gitrepo.yaml << EOF
    apiVersion: fleet.cattle.io/v1alpha1
    kind: GitRepo
    metadata:
      name: lab-deployments
      namespace: fleet-default
    spec:
      branch: advanced
      correctDrift:
        enabled: true
      paths:
        - instructors/lab-deployments
      repo: https://github.com/rancherlabs/cfl-summit-lab
      targets:
        - clusterSelector:
            matchExpressions:
              - key: provider.cattle.io
                operator: NotIn
                values:
                  - harvester
    EOF

    cat > /var/lib/rancher/rke2/server/manifests/lab-chaos-gitrepo.yaml << EOF
    apiVersion: fleet.cattle.io/v1alpha1
    kind: GitRepo
    metadata:
      name: lab-deployments-chaos
      namespace: fleet-default
    spec:
      branch: advanced
      correctDrift:
        enabled: true
      paths:
        - instructors/lab-deployments-chaos
      paused: true
      repo: https://github.com/rancherlabs/cfl-summit-lab
      targets:
        - clusterSelector:
            matchExpressions:
              - key: provider.cattle.io
                operator: NotIn
                values:
                  - harvester
    EOF

    # Install helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  END
}

resource "rancher2_bootstrap" "admin" {
  depends_on = [module.rancher_rke2_cluster]
  provider = rancher2.bootstrap
  initial_password = var.rancher_password
  password = var.rancher_password
  telemetry = false
}

resource "rancher2_cluster" "imported-cluster" {
  count = var.attendees
  name        = "${count.index + 1}-${var.prefix}"
  provider    = rancher2.admin
  description = "CFL lab cluster - ${count.index + 1}-${var.prefix}"

  lifecycle {
    ignore_changes = [labels]
  }
}

module "downstream_nodes" {
  depends_on = [rancher2_cluster.imported-cluster]
  count               = var.attendees
  source              = "./aws-rke2-module"
  aws_region          = var.aws_region
  prefix              = "${count.index + 1}-${var.prefix}"
  instance_count      = 1
  create_ssh_key_pair = true
  instance_type = var.downstream_instance_type
  spot_instances      = var.spot_instances
  user_data           = <<-END
    #!/bin/sh

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
    # Install terraform
    curl -OLs https://releases.hashicorp.com/terraform/1.9.6/terraform_1.9.6_linux_amd64.zip
    unzip terraform_1.9.6_linux_amd64.zip -d /usr/local/bin

    export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
    PATH="$PATH:/var/lib/rancher/rke2/bin"
    echo "Checking API requests succeed"
    count=0
    while ! kubectl get nodes
      do
        echo -n "."
        ((count++))
        if [ $count -ge 5 ]
          then
            sleep $count
        fi
        if [ $count -ge 60 ]
          then
            echo -e "\n$(timestamp) Somethings up, kubectl commands are not succeeding, sorry!"
            exit 1
        fi
    done
    sleep 2
    ${rancher2_cluster.imported-cluster[count.index].cluster_registration_token[0].insecure_command}
  END
}

locals {
  rancher-node-ip = module.rancher_rke2_cluster.instances_public_ip
  rancher-node-key = "${basename(module.rancher_rke2_cluster.ssh_key_path)}"
  downstream-node-ips = [for i, v in flatten(module.downstream_nodes[*].instances_public_ip) : "${i+1}-ds-${var.prefix}: ${v}"]
  downstream-node-keys = [for i, v in module.downstream_nodes[*].ssh_key_path : "${i+1}-ds-${var.prefix}: ${basename(v)}"]  
}