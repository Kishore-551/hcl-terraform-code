terraform {
  backend "gcs" {
    bucket = "YOUR_PROJECT-tf-state"
    prefix = "dev"
  }
}

