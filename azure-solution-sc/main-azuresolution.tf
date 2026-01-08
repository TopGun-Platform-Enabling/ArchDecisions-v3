module "rg_core" {
  source       = "../../modules/resource_group"
  project_name = var.project_name
  env          = var.env
  location     = var.location
}

module "networking" {
  source       = "../../modules/networking"
  rg_name      = module.rg_core.rg_name
  location     = var.location
  env          = var.env
}

module "storage_data" {
  source          = "../../modules/storage_data"
  rg_name         = module.rg_core.rg_name
  location        = var.location
  env             = var.env
  vnet_subnet_ids = [module.networking.subnet_data_id]
}

module "key_vault" {
  source      = "../../modules/key_vault"
  rg_name     = module.rg_core.rg_name
  location    = var.location
  env         = var.env
  admin_users = ["user1@org.be"]
}

# Optioneel: data platform module (Synapse/ADF/Databricks)
module "data_platform" {
  source      = "../../modules/data_platform"
  rg_name     = module.rg_core.rg_name
  location    = var.location
  env         = var.env
  storage_id  = module.storage_data.storage_account_id
  key_vault_id = module.key_vault.key_vault_id
}
