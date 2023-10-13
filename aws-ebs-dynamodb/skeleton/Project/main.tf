module "elastic_beanstalk" {
  source                               = "../Module/elastic beanstalk"
  app_name                             = var.app_name
  app_description                      = var.app_description
  app_lifecycle_max_count              = var.app_lifecycle_max_count
  app_lifecycle_max_age_in_days        = var.app_lifecycle_max_age_in_days
  app_lifecycle_delete_source          = var.app_lifecycle_delete_source
  elastic_beanstalk_app_tags           = var.elastic_beanstalk_app_tags
  application_version_name             = var.application_version_name
  application_version_description      = var.application_version_description
  app_version_source                   = var.app_version_source
  force_delete_ebs_application_version = var.force_delete_ebs_application_version
  bucket_id                            = var.bucket_id
  policy_path                          = var.policy_path
  iam_role_tags                        = var.iam_role_tags
  tags                                 = var.tags
  tier                                 = var.tier
  elastic_beanstalk_cname              = var.elastic_beanstalk_cname
  solution_stack_name                  = var.solution_stack_name
  /* template_name = var.template_name */
  /* platform_arn = var.platform_arn */
  beanstalkappenv                      = var.beanstalkappenv
  environment_description              = var.environment_description
  settings_elastic_beanstalk_env       = var.settings_elastic_beanstalk_env
  name                                 = var.name
  template_description                 = var.template_description
  environment_id                       = var.environment_id
  setting                              = var.setting
  solution_stack_name_template         = var.solution_stack_name_template
  create_configuration_template = var.create_configuration_template
}


module "create_dynamodb" {
  source                         = "../Module/DynamoDB"
  table_name                     = var.table_name
  attributes                     = var.attributes
  partition_key                  = var.partition_key
  sort_key                       = var.sort_key
  capacity_mode                  = var.capacity_mode
  read_capacity                  = var.read_capacity
  write_capacity                 = var.write_capacity
  point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
  attribute_dynamo               = var.attribute_dynamo
  global_secondary_indexes       = var.global_secondary_indexes
  server_side_encryption         = var.server_side_encryption
  local_secondary_indexes        = var.local_secondary_indexes
  ttl_enabled_dynamo             = var.ttl_enabled_dynamo
  ttl                            = var.ttl
  stream_enabled_dynamodb        = var.stream_enabled_dynamodb
  stream_view_type_dynamodb      = var.stream_view_type_dynamodb
  autoscaling_enabled            = var.autoscaling_enabled
  autoscaling_defaults           = var.autoscaling_defaults
  local_secondary_index          = var.local_secondary_index
  global_secondary_index         = var.global_secondary_indexes
  autoscaling_read               = var.autoscaling_read
  server_side_encryption1        = var.server_side_encryption1
  autoscaling_write              = var.autoscaling_write
  autoscaling_indexes            = var.autoscaling_indexes
  table_class                    = var.table_class
  tags                           = var.tags
  replica_regions                = var.replica_regions
}

