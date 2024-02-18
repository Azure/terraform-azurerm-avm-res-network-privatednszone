# TODO: insert resources here.
# resource "azurerm_resource_group" "example" {
#   name     = var.resource_group_name
#   location = var.resource_group_location
# }

resource "azurerm_private_dns_zone" "example" {
  name = var.domain_name
  #   resource_group_name = azurerm_resource_group.example.name
  resource_group_name = var.resource_group_name
  tags                = var.dns_zone_tags

  # create the soa_record block only if the var.soa_record is not empty
  dynamic "soa_record" {
    for_each = var.soa_record != null ? [1] : []
    content {
      email        = var.soa_record.email
      expire_time  = var.soa_record.expire_time
      minimum_ttl  = var.soa_record.minimum_ttl
      refresh_time = var.soa_record.refresh_time
      retry_time   = var.soa_record.retry_time
      ttl          = var.soa_record.ttl
    }
  }
}


resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  for_each              = var.virtual_network_links
  name                  = each.value.vnetlinkname
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = each.value.vnetid
  registration_enabled  = lookup(each.value, "autoregistration", false)
  tags                  = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_a_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.a_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}


resource "azurerm_private_dns_aaaa_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.aaaa_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_cname_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.cname_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_mx_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.mx_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }
  tags = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_ptr_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.ptr_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_srv_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.srv_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      priority = record.value.priority
      weight   = record.value.weight
      target   = record.value.target
      port     = record.value.port
    }
  }
  tags = lookup(each.value, "tags", null)
}


resource "azurerm_private_dns_txt_record" "example" {
  depends_on          = [azurerm_private_dns_zone.example]
  for_each            = var.txt_records
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  zone_name           = each.value.zone_name
  ttl                 = each.value.ttl
  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value.value
    }
  }
  tags = lookup(each.value, "tags", null)
}