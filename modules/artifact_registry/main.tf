variable "region" {}

resource "google_artifact_registry_repository" "repo" {
  repository_id = "microservices"
  location      = var.region
  format        = "DOCKER"
}