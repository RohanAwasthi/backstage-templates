terraform {               //for log in ssh azureuser@publicip
  required_providers {    //exit for log out
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.66.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  
  features {}
  subscription_id = "200c7489-b327-42c4-b931-85c9259878ae"
  
}
