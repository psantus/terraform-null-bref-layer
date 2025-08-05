# Example usage of the Bref Lambda Layers module with PHP extensions

# Test with PHP extensions (PHP 8.4, x86)
module "test_with_extensions" {
  source = "../../"
  
  php_version = "84"
  cpu_type    = "x86"
  aws_region  = "us-east-1"
  php_extensions = ["gd", "imagick", "redis"]
}

# Test with different PHP version and extensions (PHP 8.3, ARM64)
module "test_php83_extensions" {
  source = "../../"
  
  php_version = "83"
  cpu_type    = "arm64"
  aws_region  = "us-west-2"
  php_extensions = ["calendar", "gmp", "ldap"]
}

# Output the results for validation
output "test_extensions_results" {
  value = {
    function_arn = module.test_with_extensions.function_layer_arn
    fpm_arn      = module.test_with_extensions.fpm_layer_arn
    console_arn  = module.test_with_extensions.console_layer_arn
    versions     = module.test_with_extensions.layer_versions
    extensions   = module.test_with_extensions.extension_layer_arns
    function_layers = module.test_with_extensions.function_layers
    fpm_layers     = module.test_with_extensions.fpm_layers
    console_layers = module.test_with_extensions.console_layers
  }
}

output "test_php83_extensions_results" {
  value = {
    function_arn = module.test_php83_extensions.function_layer_arn
    fpm_arn      = module.test_php83_extensions.fpm_layer_arn
    console_arn  = module.test_php83_extensions.console_layer_arn
    versions     = module.test_php83_extensions.layer_versions
    extensions   = module.test_php83_extensions.extension_layer_arns
    function_layers = module.test_php83_extensions.function_layers
    fpm_layers     = module.test_php83_extensions.fpm_layers
    console_layers = module.test_php83_extensions.console_layers
  }
}
