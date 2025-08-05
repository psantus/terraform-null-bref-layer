# Bref Lambda Layers Module Examples

This directory contains examples demonstrating different ways to use the Bref Lambda Layers Terraform module.

## Available Examples

### [basic/](./basic/)
Demonstrates basic usage of the module without PHP extensions:
- Default configuration (PHP 8.4, x86)
- Custom configuration (PHP 8.3, ARM64)
- Shows all three runtime types: function, FPM, and console

### [with-extensions/](./with-extensions/)
Demonstrates usage with PHP extensions:
- PHP 8.4 with common extensions (gd, imagick, redis)
- PHP 8.3 with different extensions (calendar, gmp, ldap)
- Shows how to use combined layer arrays

## Running the Examples

Navigate to any example directory and run:

```bash
cd basic/  # or with-extensions/
terraform init
terraform plan
terraform apply
```

## Cleaning Up

To clean up after testing:

```bash
terraform destroy
```
