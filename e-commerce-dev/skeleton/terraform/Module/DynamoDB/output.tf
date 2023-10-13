output "dynamodb_table_arn" {
    description = "Arn of the dynamodb table"
    value = try(aws_dynamodb_table.dynamodb_table[0].arn, aws_dynamodb_table.dynamodb_table_autoscaling[0].arn, "")
}

output "dynamodb_table_id" {
    description = "Id of the dynamodb table"
    value = try(aws_dynamodb_table.dynamodb_table[0].id, aws_dynamodb_table.dynamodb_table_autoscaling[0].id, "")
}

### Table stream arn and lable will only be returned when the stream_enabled_dynamodb is set to True
output "dynamodb_table_stream_arn" {
    description = "Arn of the stream table"
    value = var.stream_enabled_dynamodb ? try(aws_dynamodb_table.dynamodb_table[0].stream_arn, aws_dynamodb_table.dynamodb_table_autoscaling[0].stream_arn, "") : null
}

output "dynamodb_table_stream_label" {
    description = "A timestamp, in ISO 8601 format of the stream table"
    value = var.stream_enabled_dynamodb ? try(aws_dynamodb_table.dynamodb_table[0].stream_label, aws_dynamodb_table.dynamodb_table_autoscaling[0].stream_label, "") : null
}
