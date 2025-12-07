terraform {
  required_version = ">= 1.13.3"

  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.4.0"
    }
  }
}

resource "kind_cluster" "local" {
  name = var.cluster_name
  
   kind_config {
     kind = "Cluster"
     api_version =  "kind.x-k8s.io/v1alpha4"
     node{
        role = "control-plane"

        labels = {
          "ingress-ready" = "true"
        }

        kubeadm_config_patches = [
          yamlencode({
            kind = "InitConfiguration"
            nodeRegistration = {
              kubeletExtraArgs = {
                "node-labels" = "ingress-ready=true"
              }
            }
          })
        ]

        extra_port_mappings {
          container_port =      80
          host_port      =      80
          protocol       =      "TCP"
        }
        extra_port_mappings {
          container_port =      443
          host_port      =      443
          protocol       =      "TCP"
        }

     }
     node{
        role = "worker"
     }
     node{
        role = "worker"
     }
   }
}


