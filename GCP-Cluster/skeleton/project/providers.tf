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
//  # credentials = file("C:/Users/WY182AQ/Downloads/first-407310-a78185d4f709.json")
// }

provider "google" {
  project = var.project  
// project     = "int-devops-cloud-0224"
  // credentials = file("int-devops-cloud-0224-aa604c3a1df3.json")
}
 
provider "google-beta" {
  project = var.project 
// project     = "int-devops-cloud-0224"
  // credentials = file("int-devops-cloud-0224-aa604c3a1df3.json")
}
