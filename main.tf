#
# Prepare locals.
#

locals {
  walrus_metadata_project_name     = coalesce(var.walrus_metadata_project_name, "example")
  walrus_metadata_environment_name = coalesce(var.walrus_metadata_environment_name, "example")
  walrus_metadata_service_name     = coalesce(var.walrus_metadata_service_name, "rdsseeder")

  identifier = join("-", [local.walrus_metadata_project_name, local.walrus_metadata_environment_name, local.walrus_metadata_service_name])
}

locals {
  source_address        = var.source_address
  destination_address   = var.destination_address
  destination_conn_max  = var.destination_conn_max
  destination_batch_cap = var.destination_batch_cap
}

#
# Create Pipeline.
#

resource "byteset_pipeline" "rds" {
  source = {
    address = local.source_address
  }

  destination = {
    address   = local.destination_address
    conn_max  = local.destination_conn_max
    batch_cap = local.destination_batch_cap
    salt      = local.identifier
  }
}

#
# Get id.
#
locals {
  id   = byteset_pipeline.rds.id
  cost = byteset_pipeline.rds.cost
}
