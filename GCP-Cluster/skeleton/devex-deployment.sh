#!/bin/bash
gcloud auth activate-service-account --key-file=/root/credentials.json
cd project
terraform init 
terraform plan
terraform apply -auto-approve
