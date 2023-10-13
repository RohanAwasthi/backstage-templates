#---------------------------DynamoDB Table---------------------------#
### Dynamodb with autoscaling disabled
resource "aws_dynamodb_table" "dynamodb_table" {
  count            = !var.autoscaling_enabled ? 1 : 0
  name             = var.table_name
  billing_mode     = var.capacity_mode
  hash_key         = var.partition_key
  range_key        = var.sort_key
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  stream_enabled   = var.stream_enabled_dynamodb
  stream_view_type = var.stream_view_type_dynamodb
  table_class      = var.table_class
  tags             = var.tags
  dynamic "ttl" {
    for_each = var.ttl_enabled_dynamo != null ? [1] : []
    content {
      enabled        = lookup(var.ttl_enabled_dynamo, "enabled")
      attribute_name = lookup(var.ttl_enabled_dynamo, "attribute_name", null)
    }
  }
  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_indexes != null ? [1] : []
    content {
      name               = lookup(var.local_secondary_indexes, "name")
      range_key          = lookup(var.local_secondary_indexes, "range_key")
      projection_type    = lookup(var.local_secondary_indexes, "projection_type")
      non_key_attributes = lookup(var.local_secondary_indexes, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes != null ? [1] : []
    content {
      name               = lookup(var.global_secondary_indexes, "name")
      hash_key           = lookup(var.global_secondary_indexes, "hash_key")
      projection_type    = lookup(var.global_secondary_indexes, "projection_type")
      range_key          = lookup(var.global_secondary_indexes, "range_key", null)
      read_capacity      = lookup(var.global_secondary_indexes, "read_capacity", null)
      write_capacity     = lookup(var.global_secondary_indexes, "write_capacity", null)
      non_key_attributes = lookup(var.global_secondary_indexes, "non_key_attributes", null)
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption != null ? [1] : []
    content {
      enabled     = lookup(var.server_side_encryption, "enabled")
      kms_key_arn = lookup(var.server_side_encryption, "kms_key_arn", null)
    }
  }

  dynamic "replica" {
    for_each = var.replica_regions != null ? [1] : []
    content {
      region_name            = lookup(var.replica_regions, "region_name")
      kms_key_arn            = lookup(var.replica_regions, "kms_key_arn", null)
      propagate_tags         = lookup(var.replica_regions, "propagate_tags", null)
      point_in_time_recovery = lookup(var.replica_regions, "point_in_time_recovery", null)
    }
  }
}

### Dynamodb with autoscaling enabled
resource "aws_dynamodb_table" "dynamodb_table_autoscaling" {
  count            = var.autoscaling_enabled ? 1 : 0
  name             = var.table_name
  billing_mode     = var.capacity_mode
  hash_key         = var.partition_key
  range_key        = var.sort_key
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  stream_enabled   = var.stream_enabled_dynamodb
  stream_view_type = var.stream_view_type_dynamodb
  table_class      = var.table_class

  dynamic "ttl" {
    for_each = var.ttl != null ? [1] : []
    content {
      enabled        = var.ttl_enabled
      attribute_name = var.ttl_attribute_name
    }
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "attribute" {
    for_each = var.attribute_dynamo
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "local_secondary_index" {
    for_each = var.local_secondary_index != null ? [1] : []
    content {
      name               = lookup(var.local_secondary_index, "name")
      range_key          = lookup(var.local_secondary_index, "range_key")
      projection_type    = lookup(var.local_secondary_index, "projection_type")
      non_key_attributes = lookup(var.local_secondary_index, "non_key_attributes", null)
    }
  }

  dynamic "global_secondary_index" {
    for_each = var.global_secondary_index != null ? [1] : []
    content {
      name               = lookup(var.global_secondary_index, "name")
      hash_key           = lookup(var.global_secondary_index, "hash_key")
      projection_type    = lookup(var.global_secondary_index, "projection_type")
      range_key          = lookup(var.global_secondary_index, "range_key", null)
      read_capacity      = lookup(var.global_secondary_index, "read_capacity", null)
      write_capacity     = lookup(var.global_secondary_index, "write_capacity", null)
      non_key_attributes = lookup(var.global_secondary_index, "non_key_attributes", null)
    }
  }

  dynamic "server_side_encryption" {
    for_each = var.server_side_encryption1 != null ? [1] : []
    content {
      enabled     = lookup(var.server_side_encryption, "enabled")
      kms_key_arn = lookup(var.server_side_encryption, "kms_key_arn", null)
    }
  }

  lifecycle {
    ignore_changes = [read_capacity, write_capacity]
  }
}
### Creating the autoscaling target and policy for READ
resource "aws_appautoscaling_target" "table_read" {
  count              = var.autoscaling_enabled && length(var.autoscaling_read) > 0 ? 1 : 0
  max_capacity       = var.autoscaling_read["max_capacity"]
  min_capacity       = var.read_capacity
  resource_id        = "table/${aws_dynamodb_table.dynamodb_table_autoscaling[0].name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "table_read_policy" {
  count = var.autoscaling_enabled && length(var.autoscaling_read) > 0 ? 1 : 0

  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.table_read[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.table_read[0].resource_id
  scalable_dimension = aws_appautoscaling_target.table_read[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.table_read[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = lookup(var.autoscaling_read, "scale_in_cooldown", var.autoscaling_defaults["scale_in_cooldown"])
    scale_out_cooldown = lookup(var.autoscaling_read, "scale_out_cooldown", var.autoscaling_defaults["scale_out_cooldown"])
    target_value       = lookup(var.autoscaling_read, "target_value", var.autoscaling_defaults["target_value"])
  }
}

### Creating the autoscaling target and policy for WRITE
resource "aws_appautoscaling_target" "table_write" {
  count              = var.autoscaling_enabled && length(var.autoscaling_write) > 0 ? 1 : 0
  max_capacity       = var.autoscaling_write["max_capacity"]
  min_capacity       = var.write_capacity
  resource_id        = "table/${aws_dynamodb_table.dynamodb_table_autoscaling[0].name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "table_write_policy" {
  count              = var.autoscaling_enabled && length(var.autoscaling_write) > 0 ? 1 : 0
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.table_write[0].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.table_write[0].resource_id
  scalable_dimension = aws_appautoscaling_target.table_write[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.table_write[0].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = lookup(var.autoscaling_write, "scale_in_cooldown", var.autoscaling_defaults["scale_in_cooldown"])
    scale_out_cooldown = lookup(var.autoscaling_write, "scale_out_cooldown", var.autoscaling_defaults["scale_out_cooldown"])
    target_value       = lookup(var.autoscaling_write, "target_value", var.autoscaling_defaults["target_value"])
  }
}

### Creating the autoscaling target and policy for INDEX READ
resource "aws_appautoscaling_target" "index_read" {
  for_each           = var.autoscaling_enabled ? var.autoscaling_indexes : {}
  max_capacity       = each.value["read_max_capacity"]
  min_capacity       = each.value["read_min_capacity"]
  resource_id        = "table/${aws_dynamodb_table.dynamodb_table_autoscaling[0].name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "index_read_policy" {
  for_each           = var.autoscaling_enabled ? var.autoscaling_indexes : {}
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.index_read[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_read[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.index_read[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.index_read[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    scale_in_cooldown  = merge(var.autoscaling_defaults, each.value)["scale_in_cooldown"]
    scale_out_cooldown = merge(var.autoscaling_defaults, each.value)["scale_out_cooldown"]
    target_value       = merge(var.autoscaling_defaults, each.value)["target_value"]
  }
}

### Creating the autoscaling target and policy for INDEX WRITE
resource "aws_appautoscaling_target" "index_write" {
  for_each           = var.autoscaling_enabled ? var.autoscaling_indexes : {}
  max_capacity       = each.value["write_max_capacity"]
  min_capacity       = each.value["write_min_capacity"]
  resource_id        = "table/${aws_dynamodb_table.dynamodb_table_autoscaling[0].name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "index_write_policy" {
  for_each           = var.autoscaling_enabled ? var.autoscaling_indexes : {}
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.index_write[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.index_write[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.index_write[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.index_write[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    scale_in_cooldown  = merge(var.autoscaling_defaults, each.value)["scale_in_cooldown"]
    scale_out_cooldown = merge(var.autoscaling_defaults, each.value)["scale_out_cooldown"]
    target_value       = merge(var.autoscaling_defaults, each.value)["target_value"]
  }
}

