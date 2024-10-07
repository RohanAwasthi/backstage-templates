# name    = "${{values.component_id}}"
location = "east us"
sku_name = "${{values.sku_name}}"
os_type = "${{values.os_type}}"
tags = {
  "pid" = "${{values.component_id}}"
  "project" = "dev-ex"
  "env" = "demo"

}