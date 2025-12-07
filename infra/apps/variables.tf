variable "kubeconfig" {
  type         =   string
  description  =  "Kubeconfig  passed from cluster module"
}

variable "k8s_yaml_glob" {

  default =  "../k8s/*.yml"
}