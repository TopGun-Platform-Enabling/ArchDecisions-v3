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
<<<<<<< HEAD
  description = "Inherited Org token and env variable for reusability CI workflow"
  type = string
}

=======
  type        = string
  description = "Name of the SC-Arch Inherited Org Token Hashed Value"
}




>>>>>>> dcead9d479b9b1f590f3e21158809fdc917f8cb9
