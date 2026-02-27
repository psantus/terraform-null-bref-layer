# Example usage targeting Bref v3 (PHP 8.4) with extensions

module "bref_layers_v3" {
  source = "../../"

  bref_major     = 3
  php_version    = "8.4"
  cpu_type       = "arm64"
  aws_region     = "eu-central-1"
  php_extensions = ["gd", "redis"]

  # Pin to specific versions to prevent auto-updates
  # bref_catalog_url = "https://raw.githubusercontent.com/brefphp/bref/refs/tags/3.0.0/layers.json"
  # bref_extensions_catalog_url = "https://raw.githubusercontent.com/brefphp/extra-php-extensions/refs/tags/3.0.0/layers.json"
}

output "v3_results" {
  value = {
    function_arn    = module.bref_layers_v3.function_layer_arn
    fpm_arn         = module.bref_layers_v3.fpm_layer_arn
    console_arn     = module.bref_layers_v3.console_layer_arn
    versions        = module.bref_layers_v3.layer_versions
    extensions      = module.bref_layers_v3.extension_layer_arns
    function_layers = module.bref_layers_v3.function_layers
    fpm_layers      = module.bref_layers_v3.fpm_layers
    console_layers  = module.bref_layers_v3.console_layers
  }
}
