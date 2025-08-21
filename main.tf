resource "azapi_resource" "private_dns_zone" {
  location  = "global"
  name      = var.domain_name
  parent_id = var.parent_id
  # This resource creates a Private DNS Zone using the Azure API
  type           = "Microsoft.Network/privateDnsZones@2024-06-01"
  create_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  delete_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  read_headers   = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
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
  retry          = var.retry
  tags           = var.tags
  update_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}

resource "azapi_update_resource" "private_dns_zone_soa_record" {
  count = var.soa_record != null ? 1 : 0

  name      = var.soa_record.name
  parent_id = azapi_resource.private_dns_zone.id
  type      = "Microsoft.Network/privateDnsZones/SOA@2024-06-01"
  body = {
    properties = {
      soaRecord = {
        email       = var.soa_record.email
        expireTime  = var.soa_record.expire_time
        minimumTtl  = var.soa_record.minimum_ttl
        refreshTime = var.soa_record.refresh_time
        retryTime   = var.soa_record.retry_time
      }
      ttl = var.soa_record.ttl
    }
  }
  read_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  response_export_values = {
    "id"   = "id"
    "name" = "name"
    "type" = "type"
    "ttl"  = "properties.ttl"
  }
  retry          = var.retry
  update_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}

module "virtual_network_links" {
  source   = "./modules/private_dns_virtual_network_link"
  for_each = var.virtual_network_links

  name                                   = coalesce(each.value.name, each.value.vnetlinkname)
  parent_id                              = azapi_resource.private_dns_zone.id
  virtual_network_id                     = coalesce(each.value.virtual_network_id, each.value.vnetid)
  private_dns_zone_supports_private_link = each.value.private_dns_zone_supports_private_link
  registration_enabled                   = coalesce(each.value.registration_enabled, each.value.autoregistration, false)
  resolution_policy                      = each.value.resolution_policy
  tags                                   = each.value.tags
  timeouts                               = var.timeouts.vnet_links
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

  enable_telemetry                          = var.enable_telemetry
  role_assignment_definition_lookup_enabled = true
  role_assignment_definition_scope          = var.parent_id
  role_assignments                          = var.role_assignments
}

resource "azapi_resource" "role_assignments" {
  for_each = module.avm_interfaces.role_assignments_azapi

  name           = each.value.name
  parent_id      = azapi_resource.private_dns_zone.id
  type           = each.value.type
  body           = each.value.body
  create_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  delete_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  read_headers   = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
  response_export_values = {
    "id"               = "id"
    "name"             = "name"
    "type"             = "type"
    "roleDefinitionId" = "properties.roleDefinitionId"
    "principalId"      = "properties.principalId"
    "principalType"    = "properties.principalType"
    "scope"            = "properties.scope"
  }
  update_headers = var.enable_telemetry ? { "User-Agent" : local.avm_azapi_header } : null
}
