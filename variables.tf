variable "php_version" {
  description = "PHP version for the Bref layers"
  type        = string
  default     = "84"
  
  validation {
    condition = contains([
      "80", "81", "82", "83", "84"
    ], var.php_version)
    error_message = "PHP version must be one of: 80, 81, 82, 83, 84."
  }
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
