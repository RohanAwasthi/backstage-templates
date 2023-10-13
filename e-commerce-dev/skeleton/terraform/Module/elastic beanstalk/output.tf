#aws elastic beanstalk app name
output "app_name" {
  value       = aws_elastic_beanstalk_application.ebs_application.name
  description = "aws elastic beanstalk app name"
}

# Elastic Beanstalk ID
output "app_id" {
  value       = aws_elastic_beanstalk_application.ebs_application.id
  description = "Elastic Beanstalk ID"
}

#elastic beanstalk application version key
output "aws_elastic_beanstalk_env_id" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.id
  description = "ID of the Elastic Beanstalk Environment"
}

output "aws_elastic_beanstalk_env_name" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.name
  description = "Name of the Elastic Beanstalk Environment"
}

output "aws_elastic_beanstalk_env_tier" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.tier
  description = "The environment tier specified"
}

output "aws_elastic_beanstalk_env_application" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.application
  description = "The Elastic Beanstalk Application specified for this environment"
}

output "aws_elastic_beanstalk_env_cname" {
  value       = try(aws_elastic_beanstalk_environment.beanstalkappenv.cname,"")
  description = "Fully qualified DNS name for this Environment"
}

output "aws_elastic_beanstalk_env_instance" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.instances
  description = "Instances used by this Environment"
}

output "aws_elastic_beanstalk_env_autoscaling" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.autoscaling_groups
  description = "The autoscaling groups used by this Environment"
}

output "aws_elastic_beanstalk_env_load_balancer" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers
  description = "Elastic load balancers in use by this Environmen"
}

output "aws_elastic_beanstalk_env_sqs_queues" {
  value       = try(aws_elastic_beanstalk_environment.beanstalkappenv.queues,"")
  description = "SQS queues in use by this Environment"
}

output "aws_elastic_beanstalk_env_endpoint_url" {
  value       = aws_elastic_beanstalk_environment.beanstalkappenv.endpoint_url
  description = "The URL to the Load Balancer for this Environment"
}
