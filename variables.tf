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
  description = "Inherited Org token and env variable for reusability CI workflow"
  type = string
}


variable "github_repository" {
  description = "New repo reusability CI workflow"
  type = string
}

