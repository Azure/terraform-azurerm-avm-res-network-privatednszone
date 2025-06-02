resource "azapi_resource" "private_dns_zone_record" {
  # This resource creates all records types provided by the user in the Private DNS Zone using the Azure API
  for_each  = local.dns_records_by_type
  type      = "Microsoft.Network/privateDnsZones/${element(split(each.key, "/"), 0)}@2024-06-01"
  name      = element(split(each.key, "/"), 1)
  parent_id = "${local.parent_resource_id}/${var.zone_name}"

  body = jsonencode({
    properties = {
      (local.dns_record_property_names[element(split(each.key, "/"), 0)]) = try(each.value.record, each.value.records)
      ttl                                                                 = each.value.ttl
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

# resource "azurerm_private_dns_a_record" "this" {
#   for_each = var.a_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   tags                = lookup(each.value, "tags", null)
# }


# resource "azurerm_private_dns_aaaa_record" "this" {
#   for_each = var.aaaa_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   tags                = lookup(each.value, "tags", null)
# }

# resource "azurerm_private_dns_cname_record" "this" {
#   for_each = var.cname_records

#   name                = each.value.name
#   record              = each.value.record
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   tags                = lookup(each.value, "tags", null)
# }

# resource "azurerm_private_dns_mx_record" "this" {
#   for_each = var.mx_records

#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   name                = each.value.name
#   tags                = lookup(each.value, "tags", null)

#   dynamic "record" {
#     for_each = each.value.records

#     content {
#       exchange   = record.value.exchange
#       preference = record.value.preference
#     }
#   }
# }

# resource "azurerm_private_dns_ptr_record" "this" {
#   for_each = var.ptr_records

#   name                = each.value.name
#   records             = each.value.records
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   tags                = lookup(each.value, "tags", null)
# }

# resource "azurerm_private_dns_srv_record" "this" {
#   for_each = var.srv_records

#   name                = each.value.name
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
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
# }


# resource "azurerm_private_dns_txt_record" "this" {
#   for_each = var.txt_records

#   name                = each.value.name
#   resource_group_name = var.resource_group_name
#   ttl                 = each.value.ttl
#   zone_name           = var.zone_name
#   tags                = lookup(each.value, "tags", null)

#   dynamic "record" {
#     for_each = each.value.records

#     content {
#       value = record.value.value
#     }
#   }
# }
