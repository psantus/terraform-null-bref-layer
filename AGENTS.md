# Repository Guidelines

## Project Structure & Module Organization
- `main.tf`, `data.tf`, `variables.tf`, `outputs.tf`, `versions.tf` contain the Terraform module logic.
- `examples/` holds runnable usage examples (`basic/`, `with-extensions/`) and a short guide in `examples/README.md`.
- `README.md` is the primary module documentation and should reflect any input/output changes.

## Build, Test, and Development Commands
- `terraform fmt` — format Terraform files in this repo.
- `terraform validate` — validate module syntax (run in repo root).
- `terraform init` — initialize providers before planning or applying.
- `terraform plan` — preview changes (run in an example directory for full usage).
- `terraform apply` — apply an example configuration.
- `terraform destroy` — clean up resources created by an example.

Example workflow:
```bash
terraform fmt
terraform validate
cd examples/basic
terraform init
terraform plan
```

## Coding Style & Naming Conventions
- Indentation: 2 spaces (Terraform standard).
- Keep locals and variables grouped by purpose (inputs, derived keys, output values).
- Naming: use clear, lower_snake_case for variables/locals; keep layer keys consistent with Bref naming (e.g., `php-84`, `arm-php-84-fpm`).
- Prefer concise comments only for non-obvious logic.

## Testing Guidelines
- No automated test suite is present.
- Use `terraform validate` and a `terraform plan` in `examples/` to sanity-check changes.
- If you add new inputs/outputs, update or add an example that exercises them.

## Commit & Pull Request Guidelines
- Commit messages in history are short, imperative, and descriptive (e.g., "Update README", "Add support for PHP extensions"). Follow that pattern.
- PRs should include:
  - A clear summary of behavior changes.
  - Any README and example updates needed to document new inputs/outputs.
  - Notes on backward compatibility and validation behavior.

## Configuration Notes
- The module fetches layer metadata from GitHub via the `http` provider (`data.tf`). Changes that affect URLs or layer resolution should be documented in `README.md`.
