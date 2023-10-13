<!-- BEGIN_TF_DOCS -->
## AWS Elastic Beanstalk
Provides an Elastic Beanstalk Application Resource. Elastic Beanstalk allows you to deploy and manage applications in the AWS cloud without worrying about the infrastructure that runs those applications.Also deployes version,environment,template with worker and webserver tier.

## Prerequisites

1-   [S3 bucket to store the application](https://aws.amazon.com/s3/)

2-   [Sample Pyhton application to store in S3 bucket](https://www.trio.dev/python/resources/python-applications)

3-  [IAM Roles for instance](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.9.0 |
| <a name="provider_random"></a> [terraform](#provider\_random) | 1.4.2 |


## Resources

| Name | Type |
|------|------|
| [aws_elastic_beanstalk_application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_application) | resource |
| [aws_elastic_beanstalk_application_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_application_version) | resource |
| [aws_elastic_beanstalk_configuration_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_configuration_template) | resource |
| [aws_elastic_beanstalk_environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_environment) | resource |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [random_integer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_description"></a> [app\_description](#input\_app\_description) | Short description of the application | `string` | n/a | yes |
| <a name="input_app_lifecycle_delete_source"></a> [app\_lifecycle\_delete\_source](#input\_app\_lifecycle\_delete\_source) | Set to true to delete a version's source bundle from S3 when the application version is deleted | `bool` | `true` | no |
| <a name="input_app_lifecycle_max_age_in_days"></a> [app\_lifecycle\_max\_age\_in\_days](#input\_app\_lifecycle\_max\_age\_in\_days) | The number of days to retain an application version ('max\_age\_in\_days' and 'max\_count' cannot be enabled simultaneously.). | `number` | n/a | yes |
| <a name="input_app_lifecycle_max_count"></a> [app\_lifecycle\_max\_count](#input\_app\_lifecycle\_max\_count) | The maximum number of application versions to retain ('max\_age\_in\_days' and 'max\_count' cannot be enabled simultaneously.) | `number` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | name for the ebs application | `string` | n/a | yes |
| <a name="input_app_version_source"></a> [app\_version\_source](#input\_app\_version\_source) | S3 object that is the Application Version source bundle. Source for application version file | `string` | n/a | yes |
| <a name="input_application_version_description"></a> [application\_version\_description](#input\_application\_version\_description) | Description of the application version | `string` | n/a | yes |
| <a name="input_application_version_name"></a> [application\_version\_name](#input\_application\_version\_name) | name for the ebs application version | `string` | n/a | yes |
| <a name="input_beanstalkappenv"></a> [beanstalkappenv](#input\_beanstalkappenv) | A unique name for this Environment. This name is used in the application URL | `string` | n/a | yes |
| <a name="input_bucket_id"></a> [bucket\_id](#input\_bucket\_id) | S3 bucket that contains the Application Version source bundle | `string` | n/a | yes |
| <a name="create_configuration_template"></a> [create\_configuration\_template](#input\create\_configuration\_template) | Whether or not create template from existing Beanstalk appliacatione | `bool` | n/a | yes |
| <a name="input_elastic_beanstalk_app_tags"></a> [elastic\_beanstalk\_app\_tags](#input\_elastic\_beanstalk\_app\_tags) | tags for the elastic beanstalk application | `map(string)` | n/a | yes |
| <a name="input_elastic_beanstalk_cname"></a> [elastic\_beanstalk\_cname](#input\_elastic\_beanstalk\_cname) | Prefix to use for the fully qualified DNS name of the Environment | `string` | `null` | no |
| <a name="input_environment_description"></a> [environment\_description](#input\_environment\_description) | Short description of the Environment | `string` | n/a | yes |
| <a name="input_environment_id"></a> [environment\_id](#input\_environment\_id) | The ID of the environment used with this configuration template | `string` | `null` | no |
| <a name="input_force_delete_ebs_application_version"></a> [force\_delete\_ebs\_application\_version](#input\_force\_delete\_ebs\_application\_version) | On delete, force an Application Version to be deleted when it may be in use by multiple Elastic Beanstalk Environments | `bool` | `true` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | tags for iam role | `map(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A unique name for this Template. | `string` | n/a | yes |
| <a name="input_platform_arn"></a> [platform\_arn](#input\_platform\_arn) | The ARN of the Elastic Beanstalk Platform to use in deployment.Conflicts with  solution\_stack\_name variable. Set one to null or comment any one. | `string` | `null` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Name of the the cloudwatch log group to store logs | `string` | `null` | no |
| <a name="input_poll_interval"></a> [poll\_interval](#input\_poll\_interval) | The time between polling the AWS API to check if changes have been applied. Use this to adjust the rate of API calls for any create or update action. Minimum 10s, maximum 180s. Omit this to use the default behavior, which is an exponential backoff | `string` | `null` | no |
| <a name="input_setting"></a> [setting](#input\_setting) | Option settings to configure the new Environment. These override specific values that are set as defaults | <pre>map(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>    resource  = string<br>  }))</pre> | `{}` | no |
| <a name="input_settings_elastic_beanstalk_env"></a> [settings\_elastic\_beanstalk\_env](#input\_settings\_elastic\_beanstalk\_env) | Option settings to configure the new Environment. These override specific values that are set as defaults | <pre>list(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>  }))</pre> | `[]` | no |
| <a name="input_solution_stack_name"></a> [solution\_stack\_name](#input\_solution\_stack\_name) | A solution stack to base your environment off of | `string` | n/a | yes |
| <a name="input_solution_stack_name_template"></a> [solution\_stack\_name\_template](#input\_solution\_stack\_name\_template) | A solution stack to base your Template off of | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | common tags for all resources | `map(string)` | n/a | yes |
| <a name="input_template_description"></a> [template\_description](#input\_template\_description) | Short description of the Template. | `string` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | The name of the Elastic Beanstalk Configuration template to use in deployment.Conflicts with  solution\_stack\_name variable. Set one to null or comment any one. | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Elastic Beanstalk Environment tier. Valid values are Worker or WebServer. If tier is left blank WebServer will be used | `string` | n/a | yes |
| <a name="input_wait_for_ready_timeout"></a> [wait\_for\_ready\_timeout](#input\_wait\_for\_ready\_timeout) | The maximum duration that Terraform should wait for an Elastic Beanstalk Environment to be in a ready state before timing out(Default 20m) | `string` | `"20m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | Elastic Beanstalk ID |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | aws elastic beanstalk app name |
| <a name="output_app_version_name"></a> [app\_version\_name](#output\_app\_version\_name) | elastic beanstalk application version name |
| <a name="output_aws_elastic_beanstalk_env_application"></a> [aws\_elastic\_beanstalk\_env\_application](#output\_aws\_elastic\_beanstalk\_env\_application) | The Elastic Beanstalk Application specified for this environment |
| <a name="output_aws_elastic_beanstalk_env_autoscaling"></a> [aws\_elastic\_beanstalk\_env\_autoscaling](#output\_aws\_elastic\_beanstalk\_env\_autoscaling) | The autoscaling groups used by this Environment |
| <a name="output_aws_elastic_beanstalk_env_cname"></a> [aws\_elastic\_beanstalk\_env\_cname](#output\_aws\_elastic\_beanstalk\_env\_cname) | Fully qualified DNS name for this Environment |
| <a name="output_aws_elastic_beanstalk_env_endpoint_url"></a> [aws\_elastic\_beanstalk\_env\_endpoint\_url](#output\_aws\_elastic\_beanstalk\_env\_endpoint\_url) | The URL to the Load Balancer for this Environment |
| <a name="output_aws_elastic_beanstalk_env_id"></a> [aws\_elastic\_beanstalk\_env\_id](#output\_aws\_elastic\_beanstalk\_env\_id) | ID of the Elastic Beanstalk Environment |
| <a name="output_aws_elastic_beanstalk_env_instance"></a> [aws\_elastic\_beanstalk\_env\_instance](#output\_aws\_elastic\_beanstalk\_env\_instance) | Instances used by this Environment |
| <a name="output_aws_elastic_beanstalk_env_load_balancer"></a> [aws\_elastic\_beanstalk\_env\_load\_balancer](#output\_aws\_elastic\_beanstalk\_env\_load\_balancer) | Elastic load balancers in use by this Environmen |
| <a name="output_aws_elastic_beanstalk_env_name"></a> [aws\_elastic\_beanstalk\_env\_name](#output\_aws\_elastic\_beanstalk\_env\_name) | Name of the Elastic Beanstalk Environment |
| <a name="output_aws_elastic_beanstalk_env_sqs_queues"></a> [aws\_elastic\_beanstalk\_env\_sqs\_queues](#output\_aws\_elastic\_beanstalk\_env\_sqs\_queues) | SQS queues in use by this Environment |
| <a name="output_aws_elastic_beanstalk_env_tier"></a> [aws\_elastic\_beanstalk\_env\_tier](#output\_aws\_elastic\_beanstalk\_env\_tier) | The environment tier specified |

## Module

```
module "elastic_beanstalk" {
  source                               = "../../../Modules/Compute/elastic beanstalk"
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
  beanstalkappenv                      = var.beanstalkappenv
  environment_description              = var.environment_description
  settings_elastic_beanstalk_env       = var.settings_elastic_beanstalk_env
  name                                 = var.name
  template_description                 = var.template_description
  environment_id                       = var.environment_id
  setting                              = var.setting
  solution_stack_name_template         = var.solution_stack_name_template
}


```
<!-- END_TF_DOCS -->