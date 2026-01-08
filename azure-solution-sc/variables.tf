variable "location" {
  type        = string
  description = "Azure region"
  default     = "westeurope"
}

variable "env" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Project / platform name"
  default     = "sciensano-data"
}
