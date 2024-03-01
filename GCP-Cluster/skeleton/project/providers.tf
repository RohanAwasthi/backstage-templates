terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.11.0"
    }
  }
}

provider "google" {
  project     = "first-407310"
  # credentials = file("C:/Users/WY182AQ/Downloads/first-407310-a78185d4f709.json")
}
