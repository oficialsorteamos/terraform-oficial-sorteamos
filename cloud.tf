resource "digitalocean_container_registry" "registry" {
  name                   = "sorteamos"
  region                 = "nyc3"
  subscription_tier_slug = "professional"
}

resource "digitalocean_vpc" "vpc" {
  name     = "devsky"
  region   = "nyc3"
}

resource "digitalocean_database_cluster" "sorteamos_database_cluster" {
  name                 = "sorteamos-database-cluster"
  engine               = "mongodb"
  version              = "4.0.2"
  size                 = "db-s-6vcpu-16gb"
  region               = "nyc3"
  private_network_uuid = digitalocean_vpc.vpc.id
  node_count           = 1
}

resource "digitalocean_database_firewall" "sorteamos_database_cluster_firewall" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.k8s_cluster.id
  }
}

resource "digitalocean_database_db" "clientex_database" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster.id
  name       = "morin"
}

resource "digitalocean_database_user" "clientex_app_user" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster.id
  name       = "morin-app-user"
}

resource "digitalocean_database_cluster" "sorteamos_database_cluster_staging" {
  name                 = "sorteamos-database-cluster-staging"
  engine               = "mongodb"
  version              = "4.0.2"
  size                 = "db-s-2vcpu-4gb"
  region               = "nyc3"
  private_network_uuid = digitalocean_vpc.vpc.id
  node_count           = 1
}

resource "digitalocean_database_firewall" "sorteamos_database_cluster_firewall_staging" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster_staging.id

  rule {
    type  = "k8s"
    value = digitalocean_kubernetes_cluster.k8s_cluster.id
  }
}

resource "digitalocean_database_db" "sorteamos_database_staging" {
  cluster_id = digitalocean_database_cluster.sorteamos_database_cluster_staging.id
  name       = "sorteamos"
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name         = "devsky-k8s"
  region       = "nyc3"
  version      = "1.28.6-do.0"
  auto_upgrade = false
  vpc_uuid     = digitalocean_vpc.vpc.id
  ha           = true

  node_pool {
    name       = "worker-pool"
    size       = "s-4vcpu-8gb"
    node_count = 20
  }
}

