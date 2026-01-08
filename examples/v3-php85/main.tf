# Example usage targeting Bref v3 (PHP 8.5)

module "bref_layers_v3" {
  source = "../../"

  bref_major  = 3
  php_version = "8.5"
  cpu_type    = "arm64"
  aws_region  = "eu-central-1"

  # Override to pin a newer Bref v3 catalog if needed.
  # bref_catalog_url = "https://raw.githubusercontent.com/brefphp/bref/3.0.0-beta2/layers.json"
}

output "v3_results" {
  value = {
    function_arn = module.bref_layers_v3.function_layer_arn
    fpm_arn      = module.bref_layers_v3.fpm_layer_arn
    console_arn  = module.bref_layers_v3.console_layer_arn
    versions     = module.bref_layers_v3.layer_versions
  }
}
