# Fetch the latest Bref layer versions from GitHub
data "http" "bref_layers" {
  url = "https://raw.githubusercontent.com/brefphp/bref/master/layers.json"
  
  request_headers = {
    Accept = "application/json"
  }
}

# Fetch the latest Bref PHP extensions layer versions from GitHub
data "http" "bref_extensions" {
  url = "https://raw.githubusercontent.com/brefphp/extra-php-extensions/master/layers.json"
  
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  # Parse the JSON responses from the HTTP data sources
  layer_versions = jsondecode(data.http.bref_layers.response_body)
  extension_versions = jsondecode(data.http.bref_extensions.response_body)
  
  # Generate layer keys based on CPU type and PHP version
  cpu_prefix = var.cpu_type == "arm64" ? "arm-" : ""
  function_layer_key = "${local.cpu_prefix}php-${var.php_version}"
  fpm_layer_key = "${local.cpu_prefix}php-${var.php_version}-fpm"
  console_layer_key = "console"
  
  # Get the layer versions for the specified region
  function_layer_version = lookup(local.layer_versions[local.function_layer_key], var.aws_region, null)
  fpm_layer_version = lookup(local.layer_versions[local.fpm_layer_key], var.aws_region, null)
  console_layer_version = lookup(local.layer_versions[local.console_layer_key], var.aws_region, null)
  
  # Process PHP extensions
  extension_layer_data = {
    for ext in var.php_extensions : ext => {
      layer_key = "${ext}-php-${var.php_version}"
      version = lookup(local.extension_versions["${ext}-php-${var.php_version}"], var.aws_region, null)
    }
  }
  
  # Filter out extensions that don't exist for the specified PHP version/region
  valid_extensions = {
    for ext, data in local.extension_layer_data : ext => data
    if data.version != null
  }
  
  # Create extension ARNs map
  extension_arns = {
    for ext, data in local.valid_extensions : ext => 
    "arn:aws:lambda:${var.aws_region}:403367587399:layer:${data.layer_key}:${data.version}"
  }
}
