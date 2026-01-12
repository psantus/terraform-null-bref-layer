variable "php_version" {
  description = "PHP version for the Bref layers"
  type        = string
  default     = "84"

  validation {
    condition     = can(regex("^(php-)?[0-9]+(\\.[0-9]+)?$", var.php_version))
    error_message = "PHP version must be in the form \"84\", \"8.4\", or \"php-84\"."
  }

  validation {
    condition     = !(can(tonumber(var.bref_major)) && tonumber(var.bref_major) == 2 && replace(replace(lower(var.php_version), "php-", ""), ".", "") == "85")
    error_message = "PHP 8.5 requires bref_major = 3."
  }
}

variable "bref_major" {
  description = "Bref major version to target (2 or 3)"
  type        = any
  default     = 2

  validation {
    condition     = contains([2, 3], tonumber(var.bref_major))
    error_message = "bref_major must be 2 or 3."
  }
}

variable "bref_layers_account_id" {
  description = "AWS account ID that publishes the Bref runtime layers (defaults to v2 or v3 account based on bref_major)"
  type        = string
  default     = null
}

variable "bref_layer_name_prefix" {
  description = "Optional prefix for Bref runtime layer names (for example, \"bref-\")"
  type        = string
  default     = null
}

variable "bref_catalog_url" {
  description = "Optional override for the Bref runtime catalog URL"
  type        = string
  default     = null
}

variable "cpu_type" {
  description = "CPU architecture type (x86 or arm64)"
  type        = string
  default     = "x86"

  validation {
    condition     = contains(["x86", "arm64"], var.cpu_type)
    error_message = "CPU type must be either 'x86' or 'arm64'."
  }
}

variable "aws_region" {
  description = "AWS region where the layers will be used"
  type        = string
}

variable "php_extensions" {
  description = "List of PHP extensions to include (maximum 9 extensions)"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.php_extensions) <= 9
    error_message = "Maximum 9 PHP extensions are allowed."
  }

  validation {
    condition = alltrue([
      for ext in var.php_extensions : can(regex("^[a-z0-9_-]+$", ext))
    ])
    error_message = "PHP extension names must contain only lowercase letters, numbers, underscores, and hyphens."
  }
}
