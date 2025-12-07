
locals {
  yaml_dir = "${path.root}/../k8s"

  yaml_files = toset(
    flatten([
      fileset(local.yaml_dir, "**/*.yaml"),
      fileset(local.yaml_dir, "**/*.yml"),
    ])
  )

  yaml_map = {
    for f in local.yaml_files :
    f => "${local.yaml_dir}/${f}"
  }
  
  namespace = "book-platform" 
}

resource "helm_release" "nginx" {
   name                 = "nginx-ingress"
   repository           = "https://kubernetes.github.io/ingress-nginx"
   chart                = "ingress-nginx"
   namespace            = "ingress-nginx"
   create_namespace     = true
   values = [
    file("${path.module}/nginx-values.yaml")
  ]
}

resource "kubectl_manifest" "manifests" {
  for_each = local.yaml_map
  yaml_body = file(each.value)
}