# TODO: insert resources here.
# resource "azurerm_resource_group" "this" {
#   name     = var.resource_group_name
#   location = var.resource_group_location
# }

resource "azurerm_private_dns_zone" "this" {
  name = var.domain_name
  #   resource_group_name = azurerm_resource_group.this.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

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


resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.virtual_network_links

  name                  = each.value.vnetlinkname
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = each.value.vnetid
  registration_enabled  = lookup(each.value, "autoregistration", false)
  tags                  = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_a_record" "this" {
  for_each = var.a_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_private_dns_zone.this]
}


resource "azurerm_private_dns_aaaa_record" "this" {
  for_each = var.aaaa_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_private_dns_zone.this]
}

resource "azurerm_private_dns_cname_record" "this" {
  for_each = var.cname_records

  name                = each.value.name
  record              = each.value.record
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_private_dns_zone.this]
}

resource "azurerm_private_dns_mx_record" "this" {
  for_each = var.mx_records

  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  name                = each.value.name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records

    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }

  depends_on = [azurerm_private_dns_zone.this]
}

resource "azurerm_private_dns_ptr_record" "this" {
  for_each = var.ptr_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  depends_on = [azurerm_private_dns_zone.this]
}

resource "azurerm_private_dns_srv_record" "this" {
  for_each = var.srv_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records

    content {
      port     = record.value.port
      priority = record.value.priority
      target   = record.value.target
      weight   = record.value.weight
    }
  }

  depends_on = [azurerm_private_dns_zone.this]
}


resource "azurerm_private_dns_txt_record" "this" {
  for_each = var.txt_records

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value.value
    }
  }

  depends_on = [azurerm_private_dns_zone.this]
}