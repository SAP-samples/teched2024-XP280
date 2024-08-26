# ------------------------------------------------------------------------------------------------------
# Setup of names in accordance to naming convention
# ------------------------------------------------------------------------------------------------------
resource "random_uuid" "uuid" {}

locals {
  subaccount_domain = lower(replace("${var.subaccount_domain_prefix}-${random_uuid.uuid.result}", "_", "-"))
}

# ------------------------------------------------------------------------------------------------------
# Creation of subaccount
# ------------------------------------------------------------------------------------------------------
resource "btp_subaccount" "sa_build" {
  name      = var.subaccount_name
  subdomain = local.subaccount_domain
  region    = lower(var.region)
}

# ------------------------------------------------------------------------------------------------------
# Setup SAP Build Code
# ------------------------------------------------------------------------------------------------------
module "build_code" {
  source = "../../modules/build_code/"

  subaccount_id  = btp_subaccount.sa_build.id

  application_studio_admins             = var.application_studio_admins
  application_studio_developers         = var.application_studio_developers
  application_studio_extension_deployer = var.application_studio_extension_deployer

  build_code_admins     = var.application_studio_admins
  build_code_developers = var.build_code_developers
}
