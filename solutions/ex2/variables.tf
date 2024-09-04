variable "globalaccount" {
  type    = string
}

variable "subaccount_domain_prefix" {
  type        = string
  description = "The prefix used for the subaccount domain"
  default     = "TechEd2024-TF"
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
