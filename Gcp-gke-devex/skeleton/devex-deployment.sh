#!/bin/bash
export PATH=$PATH:/root/gcp/google-cloud-sdk/bin
gcloud auth activate-service-account --key-file=/root/credentials.json
cd /root/gcpgketemplate/GCP-Cluster/skeleton/project
terraform init
terraform plan
terraform apply -auto-approve
