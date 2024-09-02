# ------------------------------------------------------------------------------------------------------
# Required provider
# ------------------------------------------------------------------------------------------------------
terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.6.0"
    }
  }
}

# ------------------------------------------------------------------------------------------------------
#  USERS AND ROLES
# ------------------------------------------------------------------------------------------------------
#
# Get all available subaccount roles
data "btp_subaccount_roles" "all" {
  subaccount_id = var.subaccount_id
  depends_on    = [btp_subaccount_subscription.build_code, btp_subaccount_entitlement.biz_app_studio]
}

# ------------------------------------------------------------------------------------------------------
# Setup SAP Build Code
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "build_code" {
  subaccount_id = var.subaccount_id
  service_name  = "build-code"
  plan_name     = "free"
  amount        = 1
}
# Subscribe
resource "btp_subaccount_subscription" "build_code" {
  subaccount_id = var.subaccount_id
  app_name      = "build-code"
  plan_name     = "free"
  depends_on    = [btp_subaccount_entitlement.build_code]
}
# Create role collection "Build Code Administrator"
resource "btp_subaccount_role_collection" "build_code_administrator" {
  subaccount_id = var.subaccount_id
  name          = "Build Code Administrator"
  description   = "The role collection for an administrator on SAP Build Code"

  roles = [
    for role in data.btp_subaccount_roles.all.values : {
      name                 = role.name
      role_template_app_id = role.app_id
      role_template_name   = role.role_template_name
    } if contains(["Business_Application_Studio_Administrator", "Administrator", "FeatureFlags_Dashboard_Administrator", "RegistryAdmin"], role.role_template_name)
  ]
}
# Assign users to the role collection "Build Code Administrator"
resource "btp_subaccount_role_collection_assignment" "build_code_administrator" {
  for_each             = toset(var.build_code_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Build Code Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_role_collection.build_code_administrator]
}
# Create role collection "Build Code Developer"  
resource "btp_subaccount_role_collection" "build_code_developer" {
  subaccount_id = var.subaccount_id
  name          = "Build Code Developer"
  description   = "The role collection for a developer on SAP Build Code"

  roles = [
    for role in data.btp_subaccount_roles.all.values : {
      name                 = role.name
      role_template_app_id = role.app_id
      role_template_name   = role.role_template_name
    } if contains(["Business_Application_Studio_Developer", "Developer", "FeatureFlags_Dashboard_Auditor", "RegistryDeveloper"], role.role_template_name)
  ]
}
# Assign users to the role collection "Build Code Developer"
resource "btp_subaccount_role_collection_assignment" "build_code_developer" {
  for_each             = toset(var.build_code_developers)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Build Code Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_role_collection.build_code_developer]
}

# ------------------------------------------------------------------------------------------------------
# Setup SAP Business Application Studio
# ------------------------------------------------------------------------------------------------------
# Entitle
resource "btp_subaccount_entitlement" "biz_app_studio" {
  subaccount_id = var.subaccount_id
  service_name  = "sapappstudiotrial"
  plan_name     = "trial"
}
# Subscribe
resource "btp_subaccount_subscription" "biz_app_studio" {
  subaccount_id = var.subaccount_id
  app_name      = "sapappstudiotrial"
  plan_name     = "trial"
  depends_on    = [btp_subaccount_entitlement.biz_app_studio]
}
# Assign users to the role collection "Business_Application_Studio_Administrator"
resource "btp_subaccount_role_collection_assignment" "app_studio_admin" {
  for_each             = toset(var.application_studio_admins)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Business_Application_Studio_Administrator"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.biz_app_studio]
}
# Assign users to the role collection "Business_Application_Studio_Developer"
resource "btp_subaccount_role_collection_assignment" "app_studio_developer" {
  for_each             = toset(var.application_studio_developers)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Business_Application_Studio_Developer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.biz_app_studio]
}
# Assign users to the role collection "Business_Application_Studio_Developer"
resource "btp_subaccount_role_collection_assignment" "app_studio_ext_deployer" {
  for_each             = toset(var.application_studio_extension_deployer)
  subaccount_id        = var.subaccount_id
  role_collection_name = "Business_Application_Studio_Extension_Deployer"
  user_name            = each.value
  depends_on           = [btp_subaccount_subscription.biz_app_studio]
}
