resource "azapi_resource" "private_dns_zone" {
  # This resource creates a Private DNS Zone using the Azure API
  type      = "Microsoft.Network/privateDnsZones@2024-06-01"
  name      = var.domain_name
  location  = "global"
  parent_id = local.parent_resource_id

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

resource "azapi_resource" "private_dns_zone_soa_record" {
  count     = var.soa_record != null ? 1 : 0
  type      = "Microsoft.Network/privateDnsZones/SOA@2024-06-01"
  name      = "soa"
  parent_id = azapi_resource.private_dns_zone.id

  body = jsonencode({
    properties = {
      soaRecord = var.soa_record
    }
  })
  tags = each.value.tags

  timeouts {
    create = var.timeouts.dns_zones.create
    delete = var.timeouts.dns_zones.delete
    read   = var.timeouts.dns_zones.read
    update = var.timeouts.dns_zones.update
  }
}

module "dns_records" {
  source = "./modules/addrecords"
  # This module creates various DNS records in the Private DNS Zone
  subscription_id     = var.subscription_id
  resource_group_name = var.resource_group_name
  zone_name           = azapi_resource.private_dns_zone.output.name
  a_records           = var.a_records
  aaaa_records        = var.aaaa_records
  cname_records       = var.cname_records
  mx_records          = var.mx_records
  ptr_records         = var.ptr_records
  srv_records         = var.srv_records
  txt_records         = var.txt_records
}

resource "azapi_resource" "private_dns_zone_network_link" {
  # This resource creates Virtual Network Links for the Private DNS Zone using the Azure API
  for_each  = var.virtual_network_links
  type      = "Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01"
  name      = each.value.vnetlinkname
  parent_id = azapi_resource.private_dns_zone.id

  body = jsonencode({
    properties = {
      registrationEnabled = lookup(each.value, "autoregistration", false)
      resolutionPolicy    = lookup(each.value, "resolutionPolicy", "Default")
      virtualNetwork = {
        id = each.value.vnetid
      }
    }
  })
  tags = each.value.tags

  timeouts {
    create = var.timeouts.vnet_links.create
    delete = var.timeouts.vnet_links.delete
    read   = var.timeouts.vnet_links.read
    update = var.timeouts.vnet_links.update
  }
}

resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = azapi_resource.private_dns_zone.id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_type                         = each.value.principal_type
  role_definition_id                     = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_definition_id_or_name : null
  role_definition_name                   = strcontains(lower(each.value.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

# resource "azurerm_private_dns_zone" "this" {
#   name                = var.domain_name
#   resource_group_name = var.resource_group_name
#   tags                = var.tags

#   # create the soa_record block only if the var.soa_record is not empty
#   dynamic "soa_record" {
#     for_each = var.soa_record != null ? [1] : []

#     content {
#       email        = var.soa_record.email
#       expire_time  = var.soa_record.expire_time
#       minimum_ttl  = var.soa_record.minimum_ttl
#       refresh_time = var.soa_record.refresh_time
#       retry_time   = var.soa_record.retry_time
#       ttl          = var.soa_record.ttl
#     }
#   }
#   timeouts {
#     create = var.timeouts.dns_zones.create
#     delete = var.timeouts.dns_zones.delete
#     read   = var.timeouts.dns_zones.read
#     update = var.timeouts.dns_zones.update
#   }
# }

# resource "azurerm_private_dns_zone_virtual_network_link" "this" {
#   for_each = var.virtual_network_links

#   name                  = each.value.vnetlinkname
#   private_dns_zone_name = azurerm_private_dns_zone.this.name
#   resource_group_name   = var.resource_group_name
#   virtual_network_id    = each.value.vnetid
#   registration_enabled  = lookup(each.value, "autoregistration", false)
#   tags                  = lookup(each.value, "tags", null)

#   timeouts {
#     create = var.timeouts.vnet_links.create
#     delete = var.timeouts.vnet_links.delete
#     read   = var.timeouts.vnet_links.read
#     update = var.timeouts.vnet_links.update
#   }
# }


# resource "azurerm_private_dns_a_record" "this" {
#   for_each = var.a_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   depends_on = [azurerm_private_dns_zone.this]
# }


# resource "azurerm_private_dns_aaaa_record" "this" {
#   for_each = var.aaaa_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   depends_on = [azurerm_private_dns_zone.this]
# }

# resource "azurerm_private_dns_cname_record" "this" {
#   for_each = var.cname_records

#   name                = each.value.name
#   record              = each.value.record
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   depends_on = [azurerm_private_dns_zone.this]
# }

# resource "azurerm_private_dns_mx_record" "this" {
#   for_each = var.mx_records

#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   name                = each.value.name
#   tags                = lookup(each.value, "tags", null)

#   dynamic "record" {
#     for_each = each.value.records

#     content {
#       exchange   = record.value.exchange
#       preference = record.value.preference
#     }
#   }

#   depends_on = [azurerm_private_dns_zone.this]
# }

# resource "azurerm_private_dns_ptr_record" "this" {
#   for_each = var.ptr_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   depends_on = [azurerm_private_dns_zone.this]
# }

# resource "azurerm_private_dns_srv_record" "this" {
#   for_each = var.srv_records

#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   dynamic "record" {
#     for_each = each.value.records

#     content {
#       port     = record.value.port
#       priority = record.value.priority
#       target   = record.value.target
#       weight   = record.value.weight
#     }
#   }

#   depends_on = [azurerm_private_dns_zone.this]
# }


# resource "azurerm_private_dns_txt_record" "this" {
#   for_each = var.txt_records

#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = each.value.zone_name
#   tags                = lookup(each.value, "tags", null)

#   dynamic "record" {
#     for_each = each.value.records

#     content {
#       value = record.value.value
#     }
#   }

#   depends_on = [azurerm_private_dns_zone.this]
# }

