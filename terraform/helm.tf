resource "helm_release" "app"{
    name = "app"
    chart = "./charts/stav-app-helm"
    repository  = "/home/ubuntu/DevOps-portfolio/terraform/charts/stav-app-helm"
    values = [
    file("/home/ubuntu/DevOps-portfolio/terraform/charts/stav-app-helm/values.yaml")
  ]
}

# resource "helm_release" "prometheus" {
#   name             = "prom"
#   chart            = "kube-prometheus-stack"
#   repository       = "https://prometheus-community.github.io/helm-charts"
#   namespace        = "monitoring"
#   version          = "17.1.3"
#   create_namespace = true
#   wait             = true
#   reset_values     = true
#   max_history      = 3
# }

# resource "helm_release" "argocd" {
#     name             = "argocd"
#     chart            = ""
#     repository       = "https://github.com/stavShukrun/argo.git"
#     namespace        = "monitoring"
#     version          = "17.1.3"
#     create_namespace = true
#     wait             = true
#     reset_values     = true
#     max_history      = 3
# }
