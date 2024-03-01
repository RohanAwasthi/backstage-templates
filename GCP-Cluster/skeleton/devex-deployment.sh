#!/bin/bash
gcloud auth activate-service-account --key-file=/root/credentials.json
cd Terraform
terraform init 
terraform plan
terraform apply -auto-approve
