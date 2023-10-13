#aws_elastic_beanstalk_application resource variables
variable "app_name" {
  description = "name for the ebs application"
  type        = string
}

variable "app_description" {
  description = "Short description of the application"
  type        = string
}

variable "app_lifecycle_max_count" {
  description = "The maximum number of application versions to retain ('max_age_in_days' and 'max_count' cannot be enabled simultaneously.)"
  type        = number
}

variable "app_lifecycle_max_age_in_days" {
  description = "The number of days to retain an application version ('max_age_in_days' and 'max_count' cannot be enabled simultaneously.)."
  type        = number
}

variable "app_lifecycle_delete_source" {
  description = " Set to true to delete a version's source bundle from S3 when the application version is deleted"
  default     = true
  type        = bool
}

variable "elastic_beanstalk_app_tags" {
  description = "tags for the elastic beanstalk application"
  type        = map(string)
}

#aws_elastic_beanstalk_application_version resource variables
variable "create_version" {
  type = bool
  description = "Boolean to trigge if version will be created or not "
  default = false
}
variable "application_version_name" {
  description = "name for the ebs application version"
  type        = string
}

variable "application_version_description" {
  description = "Description of the application version"
  type        = string
}

variable "app_version_source" {
  description = "S3 object that is the Application Version source bundle. Source for application version file"
  type        = string
}

variable "force_delete_ebs_application_version" {
  description = "On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments"
  default     = true
  type        = bool
}

variable "bucket_id" {
  description = "S3 bucket that contains the Application Version source bundle"
  type        = string
}

#iam_policy_document resource variables
variable "policy_path" {
  description = "Name of the the cloudwatch log group to store logs"
  type        = string
  default     = null
}

variable "iam_role_tags" {
  description = "tags for iam role"
  type        = map(string)
}

#common tags for all the elastic beanstalk resource
variable "tags" {
  description = "common tags for all resources"
  type = map(string)
}

#elastic beanstalk environment
variable "beanstalkappenv" {
  description = "A unique name for this Environment. This name is used in the application URL"
  type        = string
}

variable "environment_description" {
  description = "Short description of the Environment"
  type        = string
}

variable "wait_for_ready_timeout" {
  description = "The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out(Default 20m)"
  default     = "20m"
  type        = string
}

variable "poll_interval" {
  description = " The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff"
  default     = null
  type        = string
}

variable "solution_stack_name" {
  description = "A solution stack to base your environment off of"
  type        = string
}

variable "tier" {
  description = "Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used"
  type        = string
}

variable "elastic_beanstalk_cname" {
  description = "Prefix to use for the fully qualified DNS name of the Environment"
  default     = null
  type        = string
}

# These conflict with each other and solution stack name  ##

/* variable "platform_arn" {
  description = "The ARN of the Elastic Beanstalk Platform to use in deployment.Conflicts with  solution_stack_name variable. Set one to null or comment any one."
  default     = null
  type        = string
} */

/* variable "template_name" {
  description = "The name of the Elastic Beanstalk Configuration template to use in deployment.Conflicts with  solution_stack_name variable. Set one to null or comment any one."
  type        = string
} */

variable "settings_elastic_beanstalk_env" {
  description = "Option settings to configure the new Environment. These override specific values that are set as defaults"
  default     = []
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))
}

#Elastic beanstalk Template
variable "name" {
  description = "A unique name for this Template."
  type        = string
}

variable "template_description" {
  description = "Short description of the Template."
  type        = string
}

variable "environment_id" {
  description = "The ID of the environment used with this configuration template"
  type        = string
  default     = null
}

variable "setting" {
  description = "Option settings to configure the new Environment. These override specific values that are set as defaults"
  type = map(object({
    namespace = string
    name      = string
    value     = string
    resource  = string
  }))
  default = {}
}

variable "solution_stack_name_template" {
  description = "A solution stack to base your Template off of"
  type        = string
  default     = null
}

variable "create_configuration_template" {
  description = " Whether or not create template from existing Beanstalk appliacation"
  type = bool
}