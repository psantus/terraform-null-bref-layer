# Fetch the latest Bref layer versions from GitHub
data "http" "bref_layers" {
  url = "https://raw.githubusercontent.com/brefphp/bref/master/layers.json"
  
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  # Parse the JSON response from the HTTP data source
  layer_versions = jsondecode(data.http.bref_layers.response_body)
  
  # Generate layer keys based on CPU type and PHP version
  cpu_prefix = var.cpu_type == "arm64" ? "arm-" : ""
  function_layer_key = "${local.cpu_prefix}php-${var.php_version}"
  fpm_layer_key = "${local.cpu_prefix}php-${var.php_version}-fpm"
  console_layer_key = "console"
  
  # Get the layer versions for the specified region
  function_layer_version = lookup(local.layer_versions[local.function_layer_key], var.aws_region, null)
  fpm_layer_version = lookup(local.layer_versions[local.fpm_layer_key], var.aws_region, null)
  console_layer_version = lookup(local.layer_versions[local.console_layer_key], var.aws_region, null)
}
