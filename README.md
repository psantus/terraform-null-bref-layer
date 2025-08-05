# Terraform Bref Lambda Layers Module

This Terraform module provides easy access to [Bref](https://bref.sh/) Lambda layer ARNs for PHP serverless applications. It dynamically fetches the latest layer versions from the official Bref repository and outputs the appropriate layer ARNs based on your PHP version and CPU architecture preferences.

## Features

- **Dynamic Layer Fetching**: Automatically retrieves the latest layer versions from Bref's GitHub repository
- **Multi-Architecture Support**: Supports both x86 and ARM64 architectures
- **Multiple PHP Versions**: Supports any PHP version that Bref supports
- **Three Runtime Types**: Provides ARNs for function, FPM, and console runtimes
- **PHP Extensions Support**: Supports up to 9 PHP extensions from Bref's extra extensions
- **Region Aware**: Automatically detects the current AWS region or accepts a custom region
- **Combined Layer Arrays**: Provides ready-to-use arrays combining runtime and extension layers

## Usage

### Basic Usage (Latest PHP version, x86 architecture)

```hcl
module "bref_layers" {
  source = "./terraform-bref-layer"
  
  aws_region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  filename         = "function.zip"
  function_name    = "example-function"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "provided.al2"
  
  layers = [
    module.bref_layers.function_layer_arn
  ]
}
```

### Custom PHP Version and Architecture

```hcl
module "bref_layers" {
  source = "./terraform-bref-layer"
  
  php_version = "83"
  cpu_type    = "arm64"
  aws_region  = "us-west-2"
}

resource "aws_lambda_function" "api" {
  filename         = "api.zip"
  function_name    = "api-function"
  role            = aws_iam_role.lambda_role.arn
  handler         = "public/index.php"
  runtime         = "provided.al2"
  architectures   = ["arm64"]
  
  layers = [
    module.bref_layers.fpm_layer_arn
  ]
}
```

### All Layer Types

```hcl
module "bref_layers" {
  source = "./terraform-bref-layer"
  
  php_version = "82"
  cpu_type    = "x86"
  aws_region  = "us-west-2"
}

# Function runtime for event-driven functions
resource "aws_lambda_function" "worker" {
  # ... other configuration
  layers = [module.bref_layers.function_layer_arn]
}

# FPM runtime for HTTP applications
resource "aws_lambda_function" "web" {
  # ... other configuration
  layers = [module.bref_layers.fpm_layer_arn]
}

# Console runtime for CLI commands
resource "aws_lambda_function" "console" {
  # ... other configuration
  layers = [module.bref_layers.console_layer_arn]
}
```

### With PHP Extensions

```hcl
module "bref_layers" {
  source = "./terraform-bref-layer"
  
  php_version = "84"
  cpu_type    = "x86"
  aws_region  = "us-east-1"
  php_extensions = ["gd", "imagick", "redis"]
}

# Lambda function with runtime and extension layers
resource "aws_lambda_function" "app_with_extensions" {
  filename         = "app.zip"
  function_name    = "app-with-extensions"
  role            = aws_iam_role.lambda_role.arn
  handler         = "public/index.php"
  runtime         = "provided.al2"
  
  # Use the combined layers array that includes runtime + extensions
  layers = module.bref_layers.fpm_layers
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| php_version | PHP version for the Bref layers | `string` | `"84"` | no |
| cpu_type | CPU architecture type (x86 or arm64) | `string` | `"x86"` | no |
| aws_region | AWS region where the layers will be used | `string` | n/a | yes |
| php_extensions | List of PHP extensions to include (maximum 9) | `list(string)` | `[]` | no |

### PHP Version Values
The module accepts any PHP version that Bref supports. Common values include:
- `"80"` - PHP 8.0
- `"81"` - PHP 8.1
- `"82"` - PHP 8.2
- `"83"` - PHP 8.3
- `"84"` - PHP 8.4 (default)
- And any future PHP versions that Bref adds support for

### CPU Type Values
- `"x86"` - x86_64 architecture (default)
- `"arm64"` - ARM64 architecture

## Outputs

| Name | Description |
|------|-------------|
| function_layer_arn | ARN of the Bref PHP function runtime layer |
| fpm_layer_arn | ARN of the Bref PHP-FPM runtime layer |
| console_layer_arn | ARN of the Bref console runtime layer |
| extension_layer_arns | Map of PHP extension names to their layer ARNs |
| function_layers | Array containing the function runtime layer ARN and all extension layer ARNs |
| fpm_layers | Array containing the FPM runtime layer ARN and all extension layer ARNs |
| console_layers | Array containing the console runtime layer ARN and all extension layer ARNs |
| php_version | PHP version used for the layers |
| cpu_type | CPU architecture type used for the layers |
| region | AWS region where the layers are located |
| php_extensions | List of PHP extensions included |
| layer_versions | Version numbers of the layers |

## Layer Types Explained

### Function Layer (`function_layer_arn`)
Use this layer for event-driven Lambda functions that process events from SQS, SNS, EventBridge, etc.

```php
<?php
// index.php
return function ($event, $context) {
    return ['statusCode' => 200, 'body' => 'Hello World'];
};
```

### FPM Layer (`fpm_layer_arn`)
Use this layer for HTTP applications, APIs, and web applications.

```php
<?php
// public/index.php
echo "Hello from PHP-FPM!";
```

### Console Layer (`console_layer_arn`)
Use this layer for CLI commands and console applications.

```php
<?php
// console.php
echo "Running console command\n";
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| http | >= 3.0 |
| null | >= 3.0 |

## Data Sources

This module uses the HTTP data source to fetch the latest layer versions from:
- `https://raw.githubusercontent.com/brefphp/bref/master/layers.json`
- `https://raw.githubusercontent.com/brefphp/extra-php-extensions/master/layers.json`

## Error Handling

The module includes validation to ensure that the requested layer combination exists. If a layer is not available for the specified PHP version, CPU type, and region combination, Terraform will fail with a descriptive error message.

## Contributing

This module dynamically fetches layer data, so it should automatically stay up-to-date with new Bref releases. However, if you encounter issues or have suggestions for improvements, please open an issue or pull request.

## License

This module is provided as-is for use with Bref Lambda layers. Please refer to the [Bref documentation](https://bref.sh/) for more information about the layers themselves.
