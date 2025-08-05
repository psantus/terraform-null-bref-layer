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

# PHP Extensions outputs
output "extension_layer_arns" {
  description = "Map of PHP extension names to their layer ARNs"
  value       = local.extension_arns
}

# Combined layer arrays for each runtime type
output "function_layers" {
  description = "Array containing the function runtime layer ARN and all extension layer ARNs"
  value       = local.function_layers
}

output "fpm_layers" {
  description = "Array containing the FPM runtime layer ARN and all extension layer ARNs"
  value       = local.fpm_layers
}

output "console_layers" {
  description = "Array containing the console runtime layer ARN and all extension layer ARNs"
  value       = local.console_layers
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

output "php_extensions" {
  description = "List of PHP extensions included"
  value       = var.php_extensions
}

output "layer_versions" {
  description = "Version numbers of the layers"
  value = {
    function = local.function_layer_version
    fpm      = local.fpm_layer_version
    console  = local.console_layer_version
    extensions = {
      for ext, data in local.valid_extensions : ext => data.version
    }
  }
}
