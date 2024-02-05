#!/bin/bash
cd Terraform
terraform init -upgrade
terraform init 
terraform plan
terraform apply -auto-approve

