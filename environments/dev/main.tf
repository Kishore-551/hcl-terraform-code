provider "google" {
  project = var.project_id
  region  = var.region
}

module "services" {
  source     = "../../modules/project_services"
  project_id = var.project_id
}

module "network" {
  source = "../../modules/network"
  region = var.region
}

module "service_accounts" {
  source     = "../../modules/service_accounts"
  project_id = var.project_id
}

module "artifact_registry" {
  source = "../../modules/artifact_registry"
  region = var.region
}

module "gke" {
  source     = "../../modules/gke"
  region     = var.region
  network    = module.network.network_name
  subnetwork = module.network.subnet_name
  gke_sa     = module.service_accounts.gke_sa_email
}