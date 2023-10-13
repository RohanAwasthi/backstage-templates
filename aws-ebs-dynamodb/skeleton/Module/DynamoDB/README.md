<!-- BEGIN_TF_DOCS -->
## DynamoDB

This module provisions dynamo DB table, table item and replica as well. 

## Prerequisite

 For Encryption, provide the KMS keys as inputs. Else default keys will be created by AWS.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.4.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.61.0 |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attribute_dynamo"></a> [attribute\_dynamo](#input\_attribute\_dynamo) | Attributes required for partition key and range key. Each attribute should have a name and type. Attribute types must be a scalar type such as (S)tring, (N)umber or (B)inary | <pre>object({<br>    name = string<br>    type = string<br>  })</pre> | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Attributes required for partition key and range key. Each attribute should have a name and type. Attribute types must be a scalar type such as (S)tring, (N)umber or (B)inary | <pre>map(object({<br>    name = string<br>    type = string<br>  }))</pre> | `{}` | no |
| <a name="input_autoscaling_defaults"></a> [autoscaling\_defaults](#input\_autoscaling\_defaults) | A map of default autoscaling settings | `map(string)` | <pre>{<br>  "scale_in_cooldown": 0,<br>  "scale_out_cooldown": 0,<br>  "target_value": 70<br>}</pre> | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Autoscaling flag | `bool` | `false` | no |
| <a name="input_autoscaling_indexes"></a> [autoscaling\_indexes](#input\_autoscaling\_indexes) | A map of index autoscaling configurations. | `map(map(string))` | `{}` | no |
| <a name="input_autoscaling_read"></a> [autoscaling\_read](#input\_autoscaling\_read) | A map of read autoscaling settings. `max_capacity` is the only required key. | `map(string)` | `{}` | no |
| <a name="input_autoscaling_write"></a> [autoscaling\_write](#input\_autoscaling\_write) | A map of write autoscaling settings. `max_capacity` is the only required key. | `map(string)` | `{}` | no |
| <a name="input_capacity_mode"></a> [capacity\_mode](#input\_capacity\_mode) | Manage the Read/Write Throughput. Has an impact on the Billing. Valid values are PROVISIONED AND PAY\_PER\_REQUES | `string` | `"PROVISIONED"` | no |
| <a name="input_global_secondary_index"></a> [global\_secondary\_index](#input\_global\_secondary\_index) | Describe a GSI for the table. | <pre>object({<br>    name               = string<br>    hash_key           = string<br>    projection_type    = string<br>    range_key          = optional(string)<br>    read_capacity      = number<br>    write_capacity     = number<br>    non_key_attributes = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | Describe a GSI for the table. | <pre>object({<br>    name               = string<br>    hash_key           = string<br>    projection_type    = string<br>    range_key          = optional(string)<br>    read_capacity      = number<br>    write_capacity     = number<br>    non_key_attributes = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_local_secondary_index"></a> [local\_secondary\_index](#input\_local\_secondary\_index) | Describe an LSI on the table. | <pre>object({<br>    name               = string<br>    range_key          = string<br>    projection_type    = string<br>    non_key_attributes = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_local_secondary_indexes"></a> [local\_secondary\_indexes](#input\_local\_secondary\_indexes) | Describe an LSI on the table. | <pre>object({<br>    name               = string<br>    range_key          = string<br>    projection_type    = string<br>    non_key_attributes = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_partition_key"></a> [partition\_key](#input\_partition\_key) | Partition key for the table. Should also be defined  as key value pair in the atrributes variable as key value pair | `string` | n/a | yes |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | Flag to enable point-in-time recovery | `bool` | `false` | no |
| <a name="input_read_capacity"></a> [read\_capacity](#input\_read\_capacity) | The number of read units for the table defined. Measured in RCU. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `5` | no |
| <a name="input_replica_regions"></a> [replica\_regions](#input\_replica\_regions) | Regions in which replicas needs to be created. | <pre>object({<br>    region_name            = string<br>    kms_key_arn            = optional(string,null)<br>    propagate_tags         = optional(bool,false)<br>    point_in_time_recovery = optional(bool,false)<br>  })</pre> | `null` | no |
| <a name="input_server_side_encryption"></a> [server\_side\_encryption](#input\_server\_side\_encryption) |  (Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS-owned Customer Master Key if this argument isn't specified| <pre>object({<br>    enabled     = bool<br>    kms_key_arn = optional(string,null)<br>  })</pre> | `null` | no |
| <a name="input_server_side_encryption1"></a> [server\_side\_encryption1](#input\_server\_side\_encryption1) |  (Optional) Encryption at rest options. AWS DynamoDB tables are automatically encrypted at rest with an AWS-owned Customer Master Key if this argument isn't specified | <pre>object({<br>    enabled     = bool<br>    kms_key_arn = optional(string,null)<br>  })</pre> | `null` | no |
| <a name="input_sort_key"></a> [sort\_key](#input\_sort\_key) | Sort key for the table. Should also be defined in the atrributes variable as key value pair | `string` | n/a | yes |
| <a name="input_stream_enabled_dynamodb"></a> [stream\_enabled\_dynamodb](#input\_stream\_enabled\_dynamodb) | Sets the streams to be enabled or disabled | `bool` | `false` | no |
| <a name="input_stream_view_type_dynamodb"></a> [stream\_view\_type\_dynamodb](#input\_stream\_view\_type\_dynamodb) | Sets the information that is written to the stream when table is modified( Options:KEYS\_ONLY, NEW\_IMAGE, OLD\_IMAGE, NEW\_AND\_OLD\_IMAGES) | `string` | `"NEW_AND_OLD_IMAGES"` | no |
| <a name="input_table_class"></a> [table\_class](#input\_table\_class) | The storage class of the table. Valid values are STANDARD and STANDARD\_INFREQUENT\_ACCESS | `string` | `null` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | Name of the DynamoDB Table | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be associated to the DynamoDB table | `map(string)` | n/a | yes |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Indicates whether ttl is enabled | <pre>object({<br>    enabled        = bool<br>    attribute_name = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_ttl_enabled_dynamo"></a> [ttl\_enabled\_dynamo](#input\_ttl\_enabled\_dynamo) | Indicates whether ttl is enabled | <pre>object({<br>    enabled        = bool<br>    attribute_name = optional(string, null)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_write_capacity"></a> [write\_capacity](#input\_write\_capacity) | The number of write units for the table defined. Measured in RCU. If the billing\_mode is PROVISIONED, this field should be greater than 0 | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_table_arn"></a> [dynamodb\_table\_arn](#output\_dynamodb\_table\_arn) | Arn of the dynamodb table |
| <a name="output_dynamodb_table_id"></a> [dynamodb\_table\_id](#output\_dynamodb\_table\_id) | Id of the dynamodb table |
| <a name="output_dynamodb_table_stream_arn"></a> [dynamodb\_table\_stream\_arn](#output\_dynamodb\_table\_stream\_arn) | Arn of the stream table |
| <a name="output_dynamodb_table_stream_label"></a> [dynamodb\_table\_stream\_label](#output\_dynamodb\_table\_stream\_label) | A timestamp, in ISO 8601 format of the stream table |

## Module

```
module "create_dynamodb" {
  source                         = "../../../Modules/Storage and Data Management/DynamoDB"
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

```
<!-- END_TF_DOCS -->