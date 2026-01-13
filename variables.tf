variable "name" {
  type        = string
  description = "Name of the SC-ArchDecisions repo ruleset"
}

variable "required_checks" {
  type        = list(string)
  description = "List of required status checks"
  default     = []
} 

variable "required_status_checks" {
  type        = list(string)
  description = "List of next iteratively checks founded by SC_Arch_Committee"
  default     = []
}

variable "github_token" {
  type        = string
  description = "Name of the SC-Arch Inherited Org Token Hashed Value"
}




