terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }
  }
}

// provider "google" {
//  project     = "first-407310"
//   credentials = file("C:/Users/WY182AQ/Downloads/first-407310-a78185d4f709.json")
// }

provider "google" {
  container_cluster_name = var.container_cluster_name
  location               = var.location
  //project     = "int-devops-cloud-0224"
  //credentials = file("/root/credentials.json")
}

provider "google-beta" {
  container_cluster_name = var.container_cluster_name
  location               = var.location
  //project     = "int-devops-cloud-0224"
  //credentials = file("/root/credentials.json")
}
