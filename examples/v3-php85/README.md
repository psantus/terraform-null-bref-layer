# Bref v3 (PHP 8.5) Example

This example shows how to target Bref v3 layers, which are published from a separate AWS account. It uses PHP 8.5 and ARM64 in `eu-central-1`.

## Usage

```bash
terraform init
terraform plan
terraform apply
```

If Bref v3 uses a different catalog URL for runtime layers, set `bref_catalog_url` in `main.tf`.
