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

variable "github_repository" {
  description = "New repo reusability CI workflow"
  type = string
}

variable "INHERIT_TOKEN2" {
  type = string
  sensitive = true
}

