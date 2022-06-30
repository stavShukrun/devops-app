resource "helm_release" "app"{
    name = "stav-app-helm"
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

resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

# eksctl create iamserviceaccount \
#   --cluster=stav-eks \
#   --namespace=kube-system \
#   --name=aws-load-balancer-controller \
#   --role-name "AmazonEKSLoadBalancerControllerRole" \
#   --attach-policy-arn=arn:aws:iam::644435390668:policy/AWSLoadBalancerControllerIAMPolicy \
#   --approve


# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Federated": "arn:aws:iam::644435390668:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/72D1DA6833D01C3093E5F0DF89F35E25"
#             },
#             "Action": "sts:AssumeRoleWithWebIdentity",
#             "Condition": {
#                 "StringEquals": {
#                     "oidc.eks.eu-west-1.amazonaws.com/id/72D1DA6833D01C3093E5F0DF89F35E25:aud": "sts.amazonaws.com",
#                     "oidc.eks.eu-west-1.amazonaws.com/id/72D1DA6833D01C3093E5F0DF89F35E25:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
#                 }
#             }
#         }
#     ]
# }


# aws iam create-role \
#   --role-name AmazonEKSLoadBalancerControllerRole \
#   --assume-role-policy-document file://"tp.json"


#   aws iam attach-role-policy \
#   --policy-arn arn:aws:iam::644435390668:policy/AWSLoadBalancerControllerIAMPolicy \
#   --role-name AmazonEKSLoadBalancerControllerRole



# apiVersion: v1
# kind: ServiceAccount
# metadata:
#   labels:
#     app.kubernetes.io/component: controller
#     app.kubernetes.io/name: aws-load-balancer-controller
#   name: aws-load-balancer-controller
#   namespace: kube-system
#   annotations:
#     eks.amazonaws.com/role-arn: arn:aws:iam::644435390668:role/AmazonEKSLoadBalancerControllerRole

