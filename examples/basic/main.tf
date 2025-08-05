# Basic example usage of the Bref Lambda Layers module (without extensions)

# Test with default values (PHP 8.4, x86)
module "test_default" {
  source = "../../"
  
  aws_region = "us-east-1"
}

# Test with custom values (PHP 8.3, ARM64)
module "test_custom" {
  source = "../../"
  
  php_version = "83"
  cpu_type    = "arm64"
  aws_region  = "us-west-2"
}

# Output the results for validation
output "test_default_results" {
  value = {
    function_arn = module.test_default.function_layer_arn
    fpm_arn      = module.test_default.fpm_layer_arn
    console_arn  = module.test_default.console_layer_arn
    versions     = module.test_default.layer_versions
    extensions   = module.test_default.extension_layer_arns
    function_layers = module.test_default.function_layers
    fpm_layers     = module.test_default.fpm_layers
    console_layers = module.test_default.console_layers
  }
}

output "test_custom_results" {
  value = {
    function_arn = module.test_custom.function_layer_arn
    fpm_arn      = module.test_custom.fpm_layer_arn
    console_arn  = module.test_custom.console_layer_arn
    versions     = module.test_custom.layer_versions
    extensions   = module.test_custom.extension_layer_arns
    function_layers = module.test_custom.function_layers
    fpm_layers     = module.test_custom.fpm_layers
    console_layers = module.test_custom.console_layers
  }
}
