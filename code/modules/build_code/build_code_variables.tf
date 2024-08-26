variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
}

variable "build_code_admins" {
  type        = list(string)
  description = "Defines the colleagues who are admins for SAP Build Code."
}

variable "build_code_developers" {
  type        = list(string)
  description = "Defines the colleagues who are developers for SAP Build Code."
}

variable "application_studio_admins" {
  type        = list(string)
  description = "Defines the colleagues who are admins for SAP Business Application Studio"
}

variable "application_studio_developers" {
  type        = list(string)
  description = "Defines the colleagues who are developers for SAP Business Application Studio"
}

variable "application_studio_extension_deployer" {
  type        = list(string)
  description = "Defines the colleagues who are extension deployers for SAP Business Application Studio"
}
