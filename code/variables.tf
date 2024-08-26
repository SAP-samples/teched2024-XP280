variable "globalaccount" {
  type    = string
  default = "xxxxxxxxtrial-ga"
}

variable "subaccount_domain_prefix" {
  type        = string
  description = "The prefix used for the subaccount domain"
  default     = "TechEd2024-TF"
}

variable "subaccount_id" {
  type        = string
  description = "The subaccount ID."
  default     = ""
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "TechEd2024-experiments"
}

variable "region" {
  type        = string
  description = "The region where the subaccount shall be created in."
  default     = "us10"
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

variable "process_automation_admins" {
  type        = list(string)
  description = "Defines the users who have the role of ProcessAutomationAdmin in SAP Build Process Automation"
}

variable "process_automation_developers" {
  type        = list(string)
  description = "Defines the users who have the role of ProcessAutomationDeveloper in SAP Build Process Automation"
}

variable "process_automation_participants" {
  type        = list(string)
  description = "Defines the users who have the role of ProcessAutomationParticipant in SAP Build Process Automation"
  default     = ["jane.doe@test.com", "john.doe@test.com"]
}
