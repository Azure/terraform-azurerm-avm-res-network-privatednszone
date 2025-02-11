resource "azurerm_private_dns_a_record" "this" {
  for_each = var.a_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  tags                = lookup(each.value, "tags", null)
}


resource "azurerm_private_dns_aaaa_record" "this" {
  for_each = var.aaaa_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_cname_record" "this" {
  for_each = var.cname_records

  name                = each.value.name
  record              = each.value.record
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_mx_record" "this" {
  for_each = var.mx_records

  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  name                = each.value.name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records

    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }
}

resource "azurerm_private_dns_ptr_record" "this" {
  for_each = var.ptr_records

  name                = each.value.name
  records             = each.value.records
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  tags                = lookup(each.value, "tags", null)
}

resource "azurerm_private_dns_srv_record" "this" {
  for_each = var.srv_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
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
}


resource "azurerm_private_dns_txt_record" "this" {
  for_each = var.txt_records

  name                = each.value.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = var.zone_name
  tags                = lookup(each.value, "tags", null)

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value.value
    }
  }
}
