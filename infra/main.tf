terraform {
  required_version = ">= 1.13.3"
  required_providers {
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "~> 2.15"
    }
    helm = {
        source = "hashicorp/helm"
        version = ">= 2.10.0"
    }
    kubectl = {
        source = "gavinbunney/kubectl" 
        version = "1.19.0"
    }
  }
}

module "cluster" {
  source = "./cluster"
}


resource "local_file" "kubeconfig_file" {
  filename = "${path.module}/kubeconfig.yaml" 
  content  = module.cluster.kubeconfig
}


provider "kubernetes" {
  config_path = local_file.kubeconfig_file.filename
}

provider "helm" {
  kubernetes = {
    config_path = local_file.kubeconfig_file.filename
  }
}

provider "kubectl" {
  config_path = local_file.kubeconfig_file.filename
}

module "apps" {
  source     = "./apps"
  kubeconfig = module.cluster.kubeconfig
}
