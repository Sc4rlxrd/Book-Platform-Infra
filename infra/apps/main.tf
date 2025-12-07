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