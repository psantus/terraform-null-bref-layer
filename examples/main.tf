# Simple test configuration to validate the module
# This file can be used for testing the module locally

# Test with default values
module "test_default" {
  source = "../"
  
  aws_region = "us-east-1"
}

# Test with custom values
module "test_custom" {
  source = "../"
  
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
  }
}

output "test_custom_results" {
  value = {
    function_arn = module.test_custom.function_layer_arn
    fpm_arn      = module.test_custom.fpm_layer_arn
    console_arn  = module.test_custom.console_layer_arn
    versions     = module.test_custom.layer_versions
  }
}
