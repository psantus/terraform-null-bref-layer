output "function_layer_arn" {
  description = "ARN of the Bref PHP function runtime layer"
  value       = local.function_layer_arn
}

output "fpm_layer_arn" {
  description = "ARN of the Bref PHP-FPM runtime layer"
  value       = local.fpm_layer_arn
}

output "console_layer_arn" {
  description = "ARN of the Bref console runtime layer"
  value       = local.console_layer_arn
}

# Additional useful outputs
output "php_version" {
  description = "PHP version used for the layers"
  value       = var.php_version
}

output "cpu_type" {
  description = "CPU architecture type used for the layers"
  value       = var.cpu_type
}

output "region" {
  description = "AWS region where the layers are located"
  value       = var.aws_region
}

output "layer_versions" {
  description = "Version numbers of the layers"
  value = {
    function = local.function_layer_version
    fpm      = local.fpm_layer_version
    console  = local.console_layer_version
  }
}
