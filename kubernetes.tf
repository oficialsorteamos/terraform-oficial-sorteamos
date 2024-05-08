data "kubectl_path_documents" "nginx_ingress" {
  pattern = "${path.module}/k8s/cluster-base/ingress-nginx/ingress-nginx.yaml"
}

resource "kubectl_manifest" "nginx_ingress" {
  count     = length(data.kubectl_path_documents.nginx_ingress.documents)
  yaml_body = element(data.kubectl_path_documents.nginx_ingress.documents, count.index)

  depends_on = [
    digitalocean_kubernetes_cluster.k8s_cluster
  ]
}

resource "time_sleep" "hairpin_proxy_prepare" {
  depends_on = [kubectl_manifest.nginx_ingress]

  create_duration = "180s"
}

data "kubectl_path_documents" "hairpin_proxy" {
  pattern = "${path.module}/k8s/cluster-base/hairpin-proxy/hairpin-proxy.yaml"
}

resource "kubectl_manifest" "hairpin_proxy" {
  count     = length(data.kubectl_path_documents.hairpin_proxy.documents)
  yaml_body = element(data.kubectl_path_documents.hairpin_proxy.documents, count.index)

  depends_on = [
    time_sleep.hairpin_proxy_prepare
  ]
}

resource "time_sleep" "cert_manager_prepare" {
  depends_on = [kubectl_manifest.hairpin_proxy]

  create_duration = "60s"
}

data "kubectl_path_documents" "cert_manager" {
  pattern = "${path.module}/k8s/cluster-base/cert-manager/cert-manager.yaml"
}

resource "kubectl_manifest" "cert_manager" {
  count     = length(data.kubectl_path_documents.cert_manager.documents)
  yaml_body = element(data.kubectl_path_documents.cert_manager.documents, count.index)

  depends_on = [
    time_sleep.cert_manager_prepare
  ]
}

data "kubectl_path_documents" "cert_issuer_staging" {
  pattern = "${path.module}/k8s/cluster-base/cert-manager/cert-issuer-staging.yaml"
}

resource "kubectl_manifest" "cert_issuer_staging" {
  count     = length(data.kubectl_path_documents.cert_issuer_staging.documents)
  yaml_body = element(data.kubectl_path_documents.cert_issuer_staging.documents, count.index)

  depends_on = [
    kubectl_manifest.cert_manager
  ]
}

data "kubectl_path_documents" "cert_issuer" {
  pattern = "${path.module}/k8s/cluster-base/cert-manager/cert-issuer.yaml"
}

resource "kubectl_manifest" "cert_issuer" {
  count     = length(data.kubectl_path_documents.cert_issuer.documents)
  yaml_body = element(data.kubectl_path_documents.cert_issuer.documents, count.index)

  depends_on = [
    kubectl_manifest.cert_manager
  ]
}

data "kubectl_path_documents" "sealed_secrets" {
  pattern = "${path.module}/k8s/cluster-base/sealed-secrets/sealed-secrets.yaml"
}

resource "kubectl_manifest" "sealed_secrets" {
  count     = length(data.kubectl_path_documents.sealed_secrets.documents)
  yaml_body = element(data.kubectl_path_documents.sealed_secrets.documents, count.index)

  depends_on = [
    kubectl_manifest.cert_manager
  ]
}

data "kubectl_path_documents" "argocd_namespace" {
  pattern = "${path.module}/k8s/cluster-base/argocd/namespace.yaml"
}

resource "kubectl_manifest" "argocd_namespace" {
    count     = length(data.kubectl_path_documents.argocd_namespace.documents)
    yaml_body = element(data.kubectl_path_documents.argocd_namespace.documents, count.index)

    depends_on = [
      kubectl_manifest.cert_manager
    ]
}

data "kubectl_path_documents" "argocd" {
  pattern = "${path.module}/k8s/cluster-base/argocd/argocd.yaml"
}

resource "kubectl_manifest" "argocd" {
    count     = length(data.kubectl_path_documents.argocd.documents)
    yaml_body = element(data.kubectl_path_documents.argocd.documents, count.index)
    override_namespace = "argocd"
    
    depends_on = [
      kubectl_manifest.argocd_namespace
    ]
}

data "kubectl_path_documents" "argocd_ingress" {
  pattern = "${path.module}/k8s/cluster-base/argocd/ingress.yaml"
}

resource "kubectl_manifest" "argocd_ingress" {
    count     = length(data.kubectl_path_documents.argocd_ingress.documents)
    yaml_body = element(data.kubectl_path_documents.argocd_ingress.documents, count.index)
    override_namespace = "argocd"
    
    depends_on = [
      kubectl_manifest.argocd_namespace
    ]
}

data "kubectl_path_documents" "metrics" {
  pattern = "${path.module}/k8s/cluster-base/metrics/metrics.yaml"
}

resource "kubectl_manifest" "metrics" {
  count     = length(data.kubectl_path_documents.metrics.documents)
  yaml_body = element(data.kubectl_path_documents.metrics.documents, count.index)
}


data "kubectl_path_documents" "portainer" {
  pattern = "${path.module}/k8s/cluster-base/portainer/portainer.yaml"
}

resource "kubectl_manifest" "portainer" {
  count     = length(data.kubectl_path_documents.portainer.documents)
  yaml_body = element(data.kubectl_path_documents.portainer.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

resource "time_sleep" "prometheus_prepare" {
  depends_on = [kubectl_manifest.cert_issuer]

  create_duration = "120s"
}

resource "helm_release" "prometheus" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "43.2.0"
  namespace  = "monitoring"

  values = [
    "${file("k8s/cluster-base/prometheus/values.yaml")}"
  ]

  depends_on = [time_sleep.prometheus_prepare]
}

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  namespace  = "monitoring"

  values = [
    "${file("k8s/cluster-base/loki/values.yaml")}"
  ]

  depends_on = [helm_release.prometheus]
}

data "kubectl_path_documents" "devtools_namespace" {
  pattern = "${path.module}/k8s/devtools/namespace.yaml"
}

resource "kubectl_manifest" "devtools_namespace" {
  count     = length(data.kubectl_path_documents.devtools_namespace.documents)
  yaml_body = element(data.kubectl_path_documents.devtools_namespace.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "phpmyadmin_staging" {
  pattern = "${path.module}/k8s/devtools/phpmyadmin/phpmyadmin-staging.yaml"
}

resource "kubectl_manifest" "phpmyadmin_staging" {
  count     = length(data.kubectl_path_documents.phpmyadmin_staging.documents)
  yaml_body = element(data.kubectl_path_documents.phpmyadmin_staging.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "phpmyadmin" {
  pattern = "${path.module}/k8s/devtools/phpmyadmin/phpmyadmin.yaml"
}

resource "kubectl_manifest" "phpmyadmin" {
  count     = length(data.kubectl_path_documents.phpmyadmin.documents)
  yaml_body = element(data.kubectl_path_documents.phpmyadmin.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "redis_commander_staging" {
  pattern = "${path.module}/k8s/devtools/redis-commander/redis-commander-staging.yaml"
}

resource "kubectl_manifest" "redis_commander_staging" {
  count     = length(data.kubectl_path_documents.redis_commander_staging.documents)
  yaml_body = element(data.kubectl_path_documents.redis_commander_staging.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

data "kubectl_path_documents" "redis_commander" {
  pattern = "${path.module}/k8s/devtools/redis-commander/redis-commander.yaml"
}

resource "kubectl_manifest" "redis_commander" {
  count     = length(data.kubectl_path_documents.redis_commander.documents)
  yaml_body = element(data.kubectl_path_documents.redis_commander.documents, count.index)

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}