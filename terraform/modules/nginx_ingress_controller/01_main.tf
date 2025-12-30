resource "helm_release" "ingress_nginx" {
  name       = "ingress-controller-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx" 
  chart      = "ingress-nginx" 
  version    = "4.14.1" 
  namespace  = "ingress-controller"
  create_namespace = true

  values = [
        <<EOF
  controller:
    replicaCount: 1
    service:
      annotations:
        service.beta.kubernetes.io/azure-load-balancer-internal: "true"
    nodeSelector:
      kubernetes.io/os: linux
  defaultBackend:
    nodeSelector:
      kubernetes.io/os: linux
  EOF
    ]

  depends_on = [var.aks_cluster_id]
}