#!/bin/bash
mkdir s3

{%- if (values.solution_stack_name =='java')  %}
aws s3 cp s3://devex-deploy/springboot-demo-app.zip /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
unzip s3/springboot-demo-app.zip -d /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
cd s3/springboot-demo-app

{%- elif (values.solution_stack_name == 'python') %}
aws s3 cp s3://devex-deploy/python.zip /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
unzip s3/python.zip -d /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
cd s3

{%- elif (values.solution_stack_name == 'node') %}  
aws s3 cp s3://devex-deploy/node.zip /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
unzip s3/node.zip -d /root/.jenkins/workspace/custom-actions/Sonar${{ values.component_id }}/s3
cd s3
{%- endif %}


{%- if (values.solution_stack_name =='java')  %}
echo "running mvn command"
export JAVA_HOME=/usr/lib/jvm/msopenjdk-17-amd64
export M2_HOME=/opt/apache-maven-3.9.3
export PATH=${M2_HOME}/bin:${PATH}
mvn sonar:sonar -Dsonar.projectKey=aws-elb-java -Dsonar.host.url=http://ey-devex.eastus.cloudapp.azure.com:9000 -Dsonar.login=33807d41f57376c8f2e9959abc3d3575dfea9fe4

{%- elif (values.solution_stack_name == 'python') %}
export PATH=$PATH:/opt/sonar-scanner-5.0.1.3006-linux/bin/
sonar-scanner -Dsonar.projectKey=aws-elb-node -Dsonar.sources=. -Dsonar.host.url=http://172.190.72.81:9000 -Dsonar.login=33807d41f57376c8f2e9959abc3d3575dfea9fe4

{%- elif (values.solution_stack_name == 'node') %}
export PATH=$PATH:/opt/sonar-scanner-5.0.1.3006-linux/bin/
sonar-scanner -Dsonar.projectKey=aws-elb-node -Dsonar.sources=. -Dsonar.host.url=http://172.190.72.81:9000 -Dsonar.login=06bb2f03cc09a44128c2c1d6134c6b56d0e4c734

{%- endif %}
