aws_region                           = "us-east-1"
aws_profile                          = "default"
policy_path                          = "policy.json"
app_name                             = "${{ values.application_name }}"
app_description                      = "EBS Application for ${{values.solution_stack_name}}" # change
app_lifecycle_max_count              = 128 #if set to 0 then set ebs_lifecycle_max_age_in_days variable
/* platform_arn          = "arn:aws:elasticbeanstalk:us-east-1:123456789012:platform/Tomcat/64bit Amazon Linux 2 v3.8.0" */
/* template_name         = "aws-elasticbeanstalk-tomcat-64bit-amazon-linux-2-v3.8.0" */
app_lifecycle_max_age_in_days        = 0   #either max_count or max_age_in_days can be set
app_lifecycle_delete_source          = true
application_version_name             = "ebs_application_version_1"
application_version_description      = "application version created by terraform"
create_version                       = true
{%- if (values.solution_stack_name =='java')  %}
app_version_source                   = "demo-app-0.0.1-SNAPSHOT.jar" # change

{%- elif (values.solution_stack_name == 'python') %}
app_version_source                   = "python.zip" # change

{%- elif (values.solution_stack_name == 'node') %}    
app_version_source                   = "nodejs.zip" # change

{%- endif %}
force_delete_ebs_application_version = true
bucket_id                            = "devex-deploy"
elastic_beanstalk_app_tags = {
  name     = "P44_ekscluster"
  PID      = "pDADEVX03"
  prj-name = "DevEx Platform"
  owner    = "DevEX Team"
}

iam_role_tags = {
  name     = "P44_ekscluster"
  PID      = "pDADEVX03"
  prj-name = "DevEx Platform"
  owner    = "DevEX Team"
}
tags = {
  name     = "P44_ekscluster"
  PID      = "pDADEVX03"
  prj-name = "DevEx Platform"
  owner    = "DevEx Team"
}

#elastic beanstalk env
tier                    = "WebServer"
elastic_beanstalk_cname = null

{%- if (values.solution_stack_name =='java')  %}
solution_stack_name = "64bit Amazon Linux 2023 v4.0.0 running Corretto 17"

{%- elif (values.solution_stack_name == 'python') %}
solution_stack_name = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"

{%- elif (values.solution_stack_name == 'node') %}    
solution_stack_name = "64bit Amazon Linux 2023 v6.0.0 running Node.js 18"

{%- endif %}

beanstalkappenv         = "${{ values.environment_name }}"
environment_description = "environment for elastic beanstalk application"
settings_elastic_beanstalk_env = [
  {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "vpc-02a08a384b02cde6a"
  },
  {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  },
  {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  },
  {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "subnet-0cd37a7fdaffd1abb, subnet-0b3f34e77775469c0"
  },
  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  },
  {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  },
  {
    namespace   = "aws:elasticbeanstalk:application:environment"
    name        = "SERVER_PORT"
    value       = "5000"
  },
  {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  },

  {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  },
  {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  },
  {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = "2"
  },
  {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

]
name                         = "Beanstalk App template"
template_description         = "This is sample template configuration for AWS CIL SDA"

# solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"
{%- if (values.solution_stack_name =='java')  %}
solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.0 running Corretto 17"
{%- elif (values.solution_stack_name == 'JAVA') %}
solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.0 running Corretto 17"

{%- elif (values.solution_stack_name == 'python') %}
solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"
{%- elif (values.solution_stack_name == 'Python') %}
solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"

{%- elif (values.solution_stack_name == 'node') %}    
solution_stack_name_template = "64bit Amazon Linux 2023 v6.0.0 running Node.js 18"
{%- elif (values.solution_stack_name == 'Node') %}    
solution_stack_name_template = "64bit Amazon Linux 2023 v6.0.0 running Node.js 18"

{%- endif %}


create_configuration_template = false

table_name    = "DB_1_${{ values.component_id }}" # change
capacity_mode = "PAY_PER_REQUEST"
attributes = {
  "configuration1" = {
    name = "UserId"
    type = "S" }
  "configuration2" = {
    name = "key2"
    type = "S" }
}
partition_key                  = "UserId"
sort_key                       = "key2"
read_capacity                  = 0
write_capacity                 = 0
point_in_time_recovery_enabled = true
global_secondary_indexes = {
  name               = "Key2Index"
  hash_key           = "UserId"
  range_key          = "key2"
  projection_type    = "INCLUDE"
  non_key_attributes = ["id"]
  write_capacity     = 5
read_capacity = 5 }
ttl= {
  enabled = false
}                   
stream_enabled_dynamodb            = true
stream_view_type_dynamodb          = "NEW_AND_OLD_IMAGES"
autoscaling_enabled                = false
autoscaling_defaults = {
  scale_in_cooldown  = 0
  scale_out_cooldown = 0
target_value = 70 }
autoscaling_read = {
  scale_in_cooldown  = 60
  scale_out_cooldown = 60
  target_value       = 30
max_capacity = 5 }
autoscaling_write = {
  scale_in_cooldown  = 60
  scale_out_cooldown = 60
  target_value       = 30
max_capacity = 5 }
autoscaling_indexes = {
  Key2Index = {
    read_max_capacity  = 30
    read_min_capacity  = 10
    write_max_capacity = 30
  write_min_capacity = 10 }
}
table_class = "STANDARD"

replica_regions = {
  region_name            = "us-east-2"
}

