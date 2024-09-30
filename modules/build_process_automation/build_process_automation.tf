
terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "~> 1.7.0"
    }
  }
}

# ------------------------------------------------------------------------------------------------------
# Add Entitlement & Create Subscription - SAP Build Process Automation service
# ------------------------------------------------------------------------------------------------------

# Add Entitlement
resource "btp_subaccount_entitlement" "build_process_automation" {
  subaccount_id = var.subaccount_id
  service_name  = "process-automation"
  plan_name     = "free"
}

# Create app subscription to SAP Build Process Automation
resource "btp_subaccount_subscription" "build_process_automation" {
  subaccount_id = var.subaccount_id
  app_name      = "process-automation"
  plan_name     = "free"
  depends_on    = [btp_subaccount_entitlement.build_process_automation]
}

# ------------------------------------------------------------------------------------------------------
# Assign Roles - SAP Build Process Automation service
# ------------------------------------------------------------------------------------------------------

# Assign users to Role Collection: ProcessAutomationAdmin
resource "btp_subaccount_role_collection_assignment" "build_process_automation_admins" {
  depends_on           = [btp_subaccount_subscription.build_process_automation]
  for_each             = toset(var.process_automation_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "ProcessAutomationAdmin"
  user_name            = each.value
}

resource "btp_subaccount_role_collection_assignment" "build_process_automation_participants" {
  depends_on           = [btp_subaccount_subscription.build_process_automation]
  for_each             = toset(var.process_automation_participants)
  subaccount_id        = var.subaccount_id
  role_collection_name = "ProcessAutomationParticipant"
  user_name            = each.value
}

resource "btp_subaccount_role_collection_assignment" "build_process_automation_developers" {
  depends_on           = [btp_subaccount_subscription.build_process_automation]
  for_each             = toset(var.process_automation_developers)
  subaccount_id        = var.subaccount_id
  role_collection_name = "ProcessAutomationDeveloper"
  user_name            = each.value
}
