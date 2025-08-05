variable "php_version" {
  description = "PHP version for the Bref layers"
  type        = string
  default     = "84"
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
