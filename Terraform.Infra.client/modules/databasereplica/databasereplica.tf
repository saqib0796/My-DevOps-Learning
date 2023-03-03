resource "null_resource" "sleep" {
  provisioner "local-exec" {
    command = "sleep 10m"
  }
}


resource "null_resource" "postgresql-entity-read-replica-migration" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [null_resource.postgresql-entity-read-replica]
  depends_on = [null_resource.sleep]
  provisioner "local-exec" {
    command = "az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_entity_postgresql_name}-${var.environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id}"
   //  az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_events_postgresql_name}-${var.environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id};
  
}

  lifecycle {
    prevent_destroy = true
  }
}
  


resource "null_resource" "postgresql-events-read-replica-migration" {
  count = var.rg_obuoc_location == "northeurope" ? 1 : 0
  //depends_on = [null_resource.postgresql-entity-read-replica]
  depends_on = [null_resource.postgresql-entity-read-replica-migration]
  provisioner "local-exec" {
    command = "az resource move --destination-group ${var.rg_obuoc_name} --ids /subscriptions/${var.prod_replica_subscription_id}/resourceGroups/${var.prod_replica_resource_group}/providers/Microsoft.DBforPostgreSQL/servers/${var.azure_events_postgresql_name}-${var.environment}-${var.suffix} --destination-subscription-id ${var.subscription_id} --subscription ${var.prod_replica_subscription_id}"
    
  }

   lifecycle {
    prevent_destroy = true
  }
  
}