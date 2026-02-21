variable "region" {}
variable "network" {}
variable "subnetwork" {}
variable "gke_sa" {}

resource "google_container_cluster" "private_cluster" {
  name     = "dev-gke"
  location = var.region

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

resource "google_container_node_pool" "primary" {
  name     = "primary-pool"
  cluster  = google_container_cluster.private_cluster.name
  location = var.region

  node_config {
    service_account = var.gke_sa
    machine_type    = "e2-medium"
  }

  node_count = 2
}