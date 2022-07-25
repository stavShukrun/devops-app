resource "helm_release" "app"{
    name = "app"
    chart = "./charts/stav-app-helm"
    repository  = "/home/stav/DevOps-portfolio/terraform/charts/stav-app-helm"
    values = [
    file("/home/stav/DevOps-portfolio/terraform/charts/stav-app-helm/values.yaml")
  ]
}

resource "helm_release" "argocd" {
    name             = "argocd"
    chart            = "argo-cd"
    repository       = "https://argoproj.github.io/argo-helm"
    namespace        = "argocd"
    version          = "4.9.7"
    create_namespace = true
    values = [
    file("/home/stav/DevOps-portfolio/terraform/charts/argocd/application.yaml")
  ]
}
