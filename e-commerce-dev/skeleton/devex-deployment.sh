#!/bin/bash
pwd
echo "running mvn command"
export JAVA_HOME=/usr/lib/jvm/msopenjdk-17-amd64
export M2_HOME=/opt/apache-maven-3.9.3
export PATH=${M2_HOME}/bin:${PATH}
mvn clean package
echo "compiled"
cd target
aws s3api put-object --bucket devex-deploy --key JtSpringProject-0.0.1-SNAPSHOT.jar --body JtSpringProject-0.0.1-SNAPSHOT.jar

cd ../terraform/Project
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
