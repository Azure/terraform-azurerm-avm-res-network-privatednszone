resource "azapi_resource" "private_dns_zone" {
  location  = "global"
  name      = var.domain_name
  parent_id = var.parent_id
  # This resource creates a Private DNS Zone using the Azure API
  type = "Microsoft.Network/privateDnsZones@2024-06-01"
  response_export_values = {
    "id"                                          = "id"
    "name"                                        = "name"
    "type"                                        = "type"
    "location"                                    = "location"
    "tags"                                        = "tags"
    "numberOfRecordSets"                          = "properties.numberOfRecordSets"
    "numberOfVirtualNetworkLinks"                 = "properties.numberOfVirtualNetworkLinks"
    "numberOfVirtualNetworkLinksWithRegistration" = "properties.numberOfVirtualNetworkLinksWithRegistration"
  }
  tags = var.tags

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}

module "virtual_network_links" {
  source   = "./modules/private_dns_virtual_network_link"
  for_each = local.virtual_network_links

  name                 = each.value.name
  parent_id            = azapi_resource.private_dns_zone.id
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = lookup(each.value, "registration_enabled", false)
  resolution_policy    = lookup(each.value, "resolution_policy", "Default")
  tags                 = lookup(each.value, "tags", null)
  timeouts             = var.timeouts.vnet_links
}

module "soa_record" {
  source = "./modules/private_dns_soa_record"
  count  = var.soa_record != null ? 1 : 0

  email        = var.soa_record.email
  expire_time  = var.soa_record.expire_time
  minimum_ttl  = var.soa_record.minimum_ttl
  name         = var.soa_record.name
  parent_id    = azapi_resource.private_dns_zone.id
  refresh_time = var.soa_record.refresh_time
  retry_time   = var.soa_record.retry_time
  ttl          = var.soa_record.ttl
  timeouts     = var.timeouts.dns_zones
}

module "a_record" {
  source   = "./modules/private_dns_a_record"
  for_each = var.a_records

  ip_addresses = coalesce(each.value.ip_addresses, toset(each.value.records))
  name         = each.value.name
  parent_id    = azapi_resource.private_dns_zone.id
  ttl          = each.value.ttl
  timeouts     = var.timeouts.dns_zones
}

module "aaaa_record" {
  source   = "./modules/private_dns_aaaa_record"
  for_each = var.aaaa_records

  ip_addresses = coalesce(each.value.ip_addresses, toset(each.value.records))
  name         = each.value.name
  parent_id    = azapi_resource.private_dns_zone.id
  ttl          = each.value.ttl
  timeouts     = var.timeouts.dns_zones
}

module "cname_record" {
  source   = "./modules/private_dns_cname_record"
  for_each = var.cname_records

  cname     = coalesce(each.value.cname, each.value.record)
  name      = each.value.name
  parent_id = azapi_resource.private_dns_zone.id
  ttl       = each.value.ttl
  timeouts  = var.timeouts.dns_zones
}

module "mx_record" {
  source   = "./modules/private_dns_mx_record"
  for_each = var.mx_records

  name      = each.value.name
  parent_id = azapi_resource.private_dns_zone.id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  timeouts  = var.timeouts.dns_zones
}

module "ptr_record" {
  source   = "./modules/private_dns_ptr_record"
  for_each = var.ptr_records

  domain_names = coalesce(each.value.domain_names, toset(each.value.records))
  name         = each.value.name
  parent_id    = azapi_resource.private_dns_zone.id
  ttl          = each.value.ttl
  timeouts     = var.timeouts.dns_zones
}

module "srv_record" {
  source   = "./modules/private_dns_srv_record"
  for_each = var.srv_records

  name      = each.value.name
  parent_id = azapi_resource.private_dns_zone.id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  timeouts  = var.timeouts.dns_zones
}

module "txt_record" {
  source   = "./modules/private_dns_txt_record"
  for_each = var.txt_records

  name      = each.value.name
  parent_id = azapi_resource.private_dns_zone.id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  timeouts  = var.timeouts.dns_zones
}

module "avm_interfaces" {
  source  = "Azure/avm-utl-interfaces/azure"
  version = "0.2.0"

  role_assignment_definition_lookup_enabled = true
  role_assignment_definition_scope          = var.parent_id
  role_assignments                          = var.role_assignments
}

resource "azapi_resource" "role_assignments" {
  for_each = module.avm_interfaces.role_assignments_azapi

  name      = each.value.name
  parent_id = azapi_resource.private_dns_zone.id
  type      = each.value.type
  body      = each.value.body
  response_export_values = {
    "id"               = "id"
    "name"             = "name"
    "type"             = "type"
    "roleDefinitionId" = "properties.roleDefinitionId"
    "principalId"      = "properties.principalId"
    "principalType"    = "properties.principalType"
    "scope"            = "properties.scope"
  }
}
