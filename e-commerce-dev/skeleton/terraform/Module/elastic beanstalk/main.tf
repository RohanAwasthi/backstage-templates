#-------------------------Locals-----------------------------------------------#
locals {
  max_age_in_days = var.app_lifecycle_max_count == 0 ? var.app_lifecycle_max_age_in_days : null
}
#-------------------end---Locals-----------------------------------------------#
#Basic role created using "aws_iam_policy_document" data resource
resource "aws_iam_role" "beanstalk_service" {
  name               = "${random_integer.id.id}-elastic_beanstalk_instance_role"
  assume_role_policy = file("${var.policy_path}")
  tags               = merge(var.tags, var.iam_role_tags)
}

# random id generator
resource "random_integer" "id" {
  min = 10000
  max = 5000000
}

#-----------Creating EBS Application , Also managing the service roles----------#
resource "aws_elastic_beanstalk_application" "ebs_application" {
  name        = var.app_name
  description = var.app_description

  appversion_lifecycle {
    service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = var.app_lifecycle_max_count
    max_age_in_days       = local.max_age_in_days
    delete_source_from_s3 = var.app_lifecycle_delete_source
  }
  tags = merge(var.tags, var.elastic_beanstalk_app_tags)
}
#----------------------------------------------------------------------------#
#-------------------Creating the Application version for EBS-----------------#
resource "aws_elastic_beanstalk_application_version" "version_ebs" {
  #count = var.create_version ? 1 : 0 
  name         = var.application_version_name
  application  = aws_elastic_beanstalk_application.ebs_application.name
  description  = var.application_version_description
  bucket       = var.bucket_id
  key          = var.app_version_source
  force_delete = var.force_delete_ebs_application_version
  tags         = merge(var.tags, var.elastic_beanstalk_app_tags)
}
#----------------------------------------------------------------------------#
#---------------------Create elastic beanstalk Environment-------------------#
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  depends_on = [ aws_elastic_beanstalk_application.ebs_application ]
  name                   = var.beanstalkappenv
  description            = var.environment_description
  application            = aws_elastic_beanstalk_application.ebs_application.name
  solution_stack_name    = var.solution_stack_name 
  tier                   = var.tier
  wait_for_ready_timeout = var.wait_for_ready_timeout
  poll_interval          = var.poll_interval
  version_label          = aws_elastic_beanstalk_application_version.version_ebs.name
  #version_label          = var.create_version ?  aws_elastic_beanstalk_application_version.version_ebs[0].name : null
  cname_prefix           = var.elastic_beanstalk_cname
  tags                   = merge(var.tags, var.elastic_beanstalk_app_tags)
  #Note: These parameters conflict with solution_stack argument and each other. That is why they are commented
  /* platform_arn          = var.platform_arn  */
  /* template_name         = var.template_name  */

  dynamic "setting" {
    for_each = var.settings_elastic_beanstalk_env
    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
    }
  }
}

#---------------------Create elastic beanstalk Template-------------------#
resource "aws_elastic_beanstalk_configuration_template" "tf_template" {
  count = var.create_configuration_template ? 1 : 0
  name           = var.name
  application    = aws_elastic_beanstalk_application.ebs_application.name
  description    = var.template_description
  environment_id = var.environment_id
  dynamic "setting" {
    for_each = var.setting
    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
      resource  = setting.value.resource
    }

  }
  solution_stack_name = var.solution_stack_name_template
}
