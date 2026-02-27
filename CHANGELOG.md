# Changelog

All notable changes to this project will be documented in this file.

## [1.2.0](https://github.com/psantus/terraform-null-bref-layer/releases/tag/v1.2.0) (2026-02-27)

### Fixes

* Switch default Bref v3 runtime catalog from `3.0.0-beta2` to stable `3.0.0`.
* Update README and v3 example override URL to stable catalog.

## [1.1.0](https://github.com/psantus/terraform-null-bref-layer/releases/tag/v1.1.0) (2026-01-13)

### Features

* *Bref v2/v3 Switch**: Target Bref v2 (default) or v3 layers via `bref_major`. Contributed by @b-kaczenski-tqgg (thanks!)
* *Avoid breaking changes*: by hardening catalog url.


## [1.0.1](https://github.com/psantus/terraform-null-bref-layer/releases/tag/v1.0.1) (2025-08-05)

### Documentation

* Fix module source path in documentation

## [1.0.0](https://github.com/psantus/terraform-null-bref-layer/releases/tag/v1.0.0) (2025-08-05)

### Features

* *Dynamic Layer Fetching**: Automatically retrieves the latest layer versions from Bref's GitHub repository
* *Multi-Architecture Support**: Supports both x86 and ARM64 architectures
* *Multiple PHP Versions**: Supports any PHP version that Bref supports
* *Three Runtime Types**: Provides ARNs for function, FPM, and console runtimes
* *PHP Extensions Support**: Supports up to 9 PHP extensions from Bref's extra extensions
* *Region Aware**: Automatically detects the current AWS region or accepts a custom region
* *Combined Layer Arrays**: Provides ready-to-use arrays combining runtime and extension layers
