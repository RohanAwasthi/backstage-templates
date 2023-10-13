#!/bin/bash
pwd
echo "running mvn command"
export JAVA_HOME=/usr/lib/jvm/msopenjdk-17-amd64
export M2_HOME=/opt/apache-maven-3.9.3
export PATH=${M2_HOME}/bin:${PATH}
mvn clean package
echo "compiled"
cd target
aws s3api put-object --bucket devexs3cf --key jar_flies/JtSpringProject-0.0.1-SNAPSHOT.jar --body JtSpringProject-0.0.1-SNAPSHOT.jar
