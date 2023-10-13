aws_region                           = "us-east-1"
aws_profile                          = "default"
policy_path                          = "policy.json"
app_name                             = "e-commerce-dev"
app_description                      = "EBS Application for e-commerce-dev " # change
app_lifecycle_max_count              = 128 #if set to 0 then set ebs_lifecycle_max_age_in_days variable
app_lifecycle_max_age_in_days        = 0   #either max_count or max_age_in_days can be set
app_lifecycle_delete_source          = true
application_version_name             = "ebs_application_version_1"
application_version_description      = "application version created by terraform"
create_version                       = true
app_version_source                   = "JtSpringProject-0.0.1-SNAPSHOT.jar" # change
force_delete_ebs_application_version = true
bucket_id                            = "devex-deploy"
elastic_beanstalk_app_tags = {
  name     = "P03_ekscluster"
  PID      = "pGNACIL01"
  prj-name = "AWS GDS CIL team"
  owner    = "vedant.purushottam.kulkarni@gds.ey.com"
}

iam_role_tags = {
  name     = "P03_ekscluster"
  PID      = "pGNACIL01"
  prj-name = "AWS GDS CIL team"
  owner    = "vedant.purushottam.kulkarni@gds.ey.com"
}
tags = {
  name     = "P03_ekscluster"
  PID      = "pGNACIL01"
  prj-name = "AWS GDS CIL team"
  owner    = "vedant.purushottam.kulkarni@gds.ey.com"
}

#elastic beanstalk env
tier                    = "WebServer"
elastic_beanstalk_cname = null

solution_stack_name = "64bit Amazon Linux 2023 v4.0.0 running Corretto 17"


beanstalkappenv         = "e-commerce-dev-env"
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

solution_stack_name_template = "64bit Amazon Linux 2023 v4.0.0 running Corretto 17"


create_configuration_template = false

table_name    = "DB_1_e_commerce_dev" # change
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

