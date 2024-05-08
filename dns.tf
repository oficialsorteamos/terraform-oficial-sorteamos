data "kubernetes_service" "service_ingress" {
  metadata {
    name      = "ingress-nginx-controller"
    namespace = "ingress-nginx"
  }

  depends_on = [ kubectl_manifest.nginx_ingress ] 
}

resource "digitalocean_domain" "dns" {
  name = "sorteamos.online"
}

resource "digitalocean_record" "k8s_cluster_wildcard" {
  domain = digitalocean_domain.dns.id
  type   = "CNAME"
  name   = "*.apps"
  value  = "apps.sorteamos.online."
}
resource "digitalocean_record" "k8s_cluster_wildcard_staging" {
  domain = digitalocean_domain.dns.id
  type   = "CNAME"
  name   = "*.dev"
  value  = "dev.sorteamos.online."
}

resource "digitalocean_record" "k8s_cluster_wildcard_devtools" {
  domain = digitalocean_domain.dns.id
  type   = "CNAME"
  name   = "*.devtools"
  value  = "devtools.sorteamos.online."
}

resource "digitalocean_record" "k8s_cluster" {
  domain = digitalocean_domain.dns.id
  type   = "A"
  name   = "apps"
  value  = data.kubernetes_service.service_ingress.status[0].load_balancer[0].ingress[0].ip

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

resource "digitalocean_record" "k8s_cluster_staging" {
  domain = digitalocean_domain.dns.id
  type   = "A"
  name   = "dev"
  value  = data.kubernetes_service.service_ingress.status[0].load_balancer[0].ingress[0].ip

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}

resource "digitalocean_record" "k8s_cluster_devtools" {
  domain = digitalocean_domain.dns.id
  type   = "A"
  name   = "devtools"
  value  = data.kubernetes_service.service_ingress.status[0].load_balancer[0].ingress[0].ip

  depends_on = [
    kubectl_manifest.nginx_ingress
  ]
}