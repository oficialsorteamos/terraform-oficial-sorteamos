terraform {
  backend "s3" {
    endpoint                = "https://nyc3.digitaloceanspaces.com"
    region                      = "us-east-1"
    bucket                      = "sorteamos"
    key                         = "terraform.tfstate"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.23.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}


provider "digitalocean" {
  token             = var.do_token
  spaces_access_id  = var.spaces_access_key
  spaces_secret_key = var.spaces_secret_key
}

provider "kubectl" {
  host                   = digitalocean_kubernetes_cluster.k8s_cluster.endpoint
  cluster_ca_certificate = base64decode(digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].cluster_ca_certificate)
  token                  = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = "${digitalocean_kubernetes_cluster.k8s_cluster.endpoint}"
    cluster_ca_certificate = "${base64decode(digitalocean_kubernetes_cluster.k8s_cluster.kube_config.0.cluster_ca_certificate)}"
    token                  = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].token
  }
}

provider "kubernetes" {
  host             = digitalocean_kubernetes_cluster.k8s_cluster.endpoint
  token            = digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.k8s_cluster.kube_config[0].cluster_ca_certificate
  )
}
