resource "azapi_resource" "private_dns_zone" {
  location  = "global"
  name      = var.domain_name
  parent_id = local.parent_resource_id
  # This resource creates a Private DNS Zone using the Azure API
  type = "Microsoft.Network/privateDnsZones@2024-06-01"
  body = jsonencode({
    tags = var.tags
  })

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}

module "virtual_network_links" {
  source   = "./modules/virtual_network_link"
  for_each = local.virtual_network_links

  parent_id            = azapi_resource.private_dns_zone.id
  name                 = each.value.name
  virtual_network_id   = each.value.vnetid
  registration_enabled = lookup(each.value, "autoregistration", false)
  resolution_policy    = lookup(each.value, "resolution_policy", "Default")
  tags                 = lookup(each.value, "tags", null)

  timeouts = var.timeouts.vnet_links

}

module "soa_record" {
  source = "./modules/private_dns_soa_record"

  parent_id    = azapi_resource.private_dns_zone.id
  email        = var.soa_record.email
  name         = var.soa_record.name
  expire_time  = var.soa_record.expire_time
  minimum_ttl  = var.soa_record.minimum_ttl
  refresh_time = var.soa_record.refresh_time
  retry_time   = var.soa_record.retry_time
  ttl          = var.soa_record.ttl
  tags         = var.soa_record

  timeouts = var.timeouts.soa_records
}

module "a_record" {
  source   = "./modules/private_dns_a_record"
  for_each = var.a_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "aaaa_record" {
  source   = "./modules/private_dns_aaaa_record"
  for_each = var.aaaa_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "cname_record" {
  source   = "./modules/private_dns_cname_record"
  for_each = var.cname_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  record    = each.value.record
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "mx_record" {
  source   = "./modules/private_dns_mx_record"
  for_each = var.mx_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "ptr_record" {
  source   = "./modules/private_dns_ptr_record"
  for_each = var.ptr_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "srv_record" {
  source   = "./modules/private_dns_srv_record"
  for_each = var.srv_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

module "txt_record" {
  source   = "./modules/private_dns_txt_record"
  for_each = var.txt_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags

  timeouts = var.timeouts.dns_zones
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = azurerm_private_dns_zone.this.id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_type                         = each.value.principal_type
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}
