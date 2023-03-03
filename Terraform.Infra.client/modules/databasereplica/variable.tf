variable "rg_obuoc_name" { }
variable "rg_obuoc_location" { }
variable "tags" { }
variable "suffix" { }
//variable "dr_suffix" { }
variable "environment" { }
variable "azure_entity_postgresql_name" { }
variable "postgresql_sku_name" { }
variable "postgresql_storage_mb" { }
variable "postgresql_backup_retention_days" { }
variable "postgresql_geo_redundant_backup" { }
variable "postgresql_server_version" { }
variable "postgresql_ssl_enforcement" { }
variable "postgresql_db_names" { }
variable "postgresql_db_charset" { }
variable "postgresql_db_collation" { }
variable "azureservices_subnet_id" { }
variable "linux_app_service_subnet_id" { }
variable "windows_app_service_subnet_id" { }
variable "obtsync_app_service_subnet_id" { }
variable "appgatway_subnet_id" { }
variable "azure_events_postgresql_name" { }
variable "postgresql_events_db_names" { }
variable "pdb_admin_login_akv_key" { }
variable "pdb_admin_pwd_akv_key" { }
variable "region" {
  type = map(bool)
    default = {
  "primary" = true
  "secondary" = false 
}
}
//variable "replica_source_resource_group" {  }
variable "subscription_id" { }
//variable "subscription_id_dev" { }
variable "prod_replica_resource_group"  { }
variable "prod_replica_subscription_id" { }
variable "prod_replica_environment" { }
variable "prod_replica_suffix" { }
//variable "subscription_id" { }
variable "terrclient_secret" { }
variable "tenant_id" { }
