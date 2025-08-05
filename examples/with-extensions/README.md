# Bref Lambda Layers with PHP Extensions Example

This example demonstrates how to use the Bref Lambda Layers module with PHP extensions.

## What this example shows

- PHP 8.4 with x86 architecture and extensions: `gd`, `imagick`, `redis`
- PHP 8.3 with ARM64 architecture and extensions: `calendar`, `gmp`, `ldap`
- Extension layer ARNs mapping
- Combined layer arrays that include both runtime and extension layers
- Version information for both runtime and extension layers

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Expected outputs

The example will output:
- Individual runtime layer ARNs
- Extension layer ARNs mapped by extension name
- Combined layer arrays containing runtime + extension layers (ready to use in Lambda functions)
- Version information for all layers including extensions

## Using the combined layers

The combined layer arrays (`function_layers`, `fpm_layers`, `console_layers`) can be directly used in your Lambda function configuration:

```hcl
resource "aws_lambda_function" "example" {
  # ... other configuration
  layers = module.bref_layers.fpm_layers  # Includes runtime + all extensions
}
```
