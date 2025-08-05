# Basic Bref Lambda Layers Example

This example demonstrates the basic usage of the Bref Lambda Layers module without PHP extensions.

## What this example shows

- Default configuration (PHP 8.4, x86 architecture)
- Custom configuration (PHP 8.3, ARM64 architecture)
- All three runtime types: function, FPM, and console
- Layer version information
- Combined layer arrays (which will only contain the runtime layers since no extensions are specified)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Expected outputs

The example will output the layer ARNs for both configurations, showing:
- Individual runtime layer ARNs
- Empty extension maps (since no extensions are requested)
- Combined layer arrays containing only the runtime layers
- Version information for all layers
