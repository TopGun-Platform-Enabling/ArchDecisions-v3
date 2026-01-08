variable "name" {
  type = string
  description = "Holds the name of the co-created module within SC Archv1 Proposed Solution Checks"
}


variable "required_checks" {
  type        = list(string)
  description = "List of required SC_Arch checks, attention whilst parsing default is blank"
  default     = []
} 

variable "required_status_checks" {
  type        = list(string)
  description = "Assessment List (owner: Architectural Committee) and fuels our SPOT for next iterations baselining"
  default     = []
}
