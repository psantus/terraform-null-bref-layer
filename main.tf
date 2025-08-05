# Validation to ensure the requested layer combinations exist
resource "null_resource" "validate_layers" {
  count = local.function_layer_version == null || local.fpm_layer_version == null || local.console_layer_version == null ? 1 : 0
  
  provisioner "local-exec" {
    command = "echo 'ERROR: One or more Bref layers not found for PHP ${var.php_version}, CPU ${var.cpu_type}, region ${var.aws_region}' && exit 1"
  }
}

# Validation to ensure all requested extensions exist
resource "null_resource" "validate_extensions" {
  count = length(var.php_extensions) > length(local.valid_extensions) ? 1 : 0
  
  provisioner "local-exec" {
    command = "echo 'ERROR: Some PHP extensions not found for PHP ${var.php_version}, region ${var.aws_region}. Missing: ${join(", ", setsubtract(toset(var.php_extensions), keys(local.valid_extensions)))}' && exit 1"
  }
}

# Construct the layer ARNs using the Bref naming convention
locals {
  # Bref layer ARN format: arn:aws:lambda:{region}:534081306603:layer:{layer-name}:{version}
  bref_account_id = "534081306603"
  
  function_layer_arn = local.function_layer_version != null ? "arn:aws:lambda:${var.aws_region}:${local.bref_account_id}:layer:${local.function_layer_key}:${local.function_layer_version}" : null
  fpm_layer_arn = local.fpm_layer_version != null ? "arn:aws:lambda:${var.aws_region}:${local.bref_account_id}:layer:${local.fpm_layer_key}:${local.fpm_layer_version}" : null
  console_layer_arn = local.console_layer_version != null ? "arn:aws:lambda:${var.aws_region}:${local.bref_account_id}:layer:${local.console_layer_key}:${local.console_layer_version}" : null
  
  # Create combined layer arrays for each runtime type
  function_layers = compact(concat(
    [local.function_layer_arn],
    values(local.extension_arns)
  ))
  
  fpm_layers = compact(concat(
    [local.fpm_layer_arn],
    values(local.extension_arns)
  ))
  
  console_layers = compact(concat(
    [local.console_layer_arn],
    values(local.extension_arns)
  ))
}
