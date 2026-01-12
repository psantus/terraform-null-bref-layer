# Fetch the latest Bref layer versions from GitHub
data "http" "bref_layers" {
  url = local.bref_catalog_url

  request_headers = {
    Accept = "application/json"
  }
}

# Fetch the latest Bref PHP extensions layer versions from GitHub
data "http" "bref_extensions" {
  url = "https://raw.githubusercontent.com/brefphp/extra-php-extensions/refs/tags/1.8.6/layers.json"

  request_headers = {
    Accept = "application/json"
  }
}

locals {
  bref_major             = tonumber(var.bref_major)
  bref_layers_account_id = var.bref_layers_account_id != null ? var.bref_layers_account_id : (local.bref_major == 3 ? "873528684822" : "534081306603")
  bref_layer_name_prefix = var.bref_layer_name_prefix != null ? var.bref_layer_name_prefix : ""
  bref_catalog_url = var.bref_catalog_url != null ? var.bref_catalog_url : (
    local.bref_major == 3
    ? "https://raw.githubusercontent.com/brefphp/bref/refs/tags/3.0.0-beta2/layers.json"
    : "https://raw.githubusercontent.com/brefphp/bref/refs/tags/2.4.16/layers.json"
  )
  php_version_normalized = replace(replace(lower(var.php_version), "php-", ""), ".", "")

  # Parse the JSON responses from the HTTP data sources
  layer_versions     = jsondecode(data.http.bref_layers.response_body)
  extension_versions = jsondecode(data.http.bref_extensions.response_body)

  # Generate layer keys based on CPU type and PHP version
  cpu_prefix            = var.cpu_type == "arm64" ? "arm-" : ""
  runtime_layer_key     = "${local.bref_layer_name_prefix}${local.cpu_prefix}php-${local.php_version_normalized}"
  function_layer_key    = local.runtime_layer_key
  fpm_layer_key         = local.bref_major == 3 ? local.runtime_layer_key : "${local.runtime_layer_key}-fpm"
  console_layer_key     = local.bref_major == 3 ? local.runtime_layer_key : "${local.bref_layer_name_prefix}console"

  # Get the layer versions for the specified region
  function_layer_version = lookup(lookup(local.layer_versions, local.function_layer_key, {}), var.aws_region, null)
  fpm_layer_version      = lookup(lookup(local.layer_versions, local.fpm_layer_key, {}), var.aws_region, null)
  console_layer_version  = lookup(lookup(local.layer_versions, local.console_layer_key, {}), var.aws_region, null)

  # Process PHP extensions
  extension_layer_data = {
    for ext in var.php_extensions : ext => {
      layer_key = "${ext}-php-${local.php_version_normalized}"
      version   = lookup(lookup(local.extension_versions, "${ext}-php-${local.php_version_normalized}", {}), var.aws_region, null)
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
