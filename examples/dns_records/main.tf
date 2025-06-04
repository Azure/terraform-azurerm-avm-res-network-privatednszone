# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

module "private_dns_zone" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source = "../../"

  domain_name           = local.domain_name
  resource_group_name   = azurerm_resource_group.avmrg.name
  subscription_id = var.subscription_id
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
}

module "a_record" {
  source   = "./modules/private_dns_a_record"
  for_each = local.a_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

module "aaaa_record" {
  source   = "./modules/private_dns_aaaa_record"
  for_each = local.aaaa_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

module "cname_record" {
  source   = "./modules/private_dns_cname_record"
  for_each = local.cname_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  record    = each.value.record
  tags      = each.value.tags
}

module "mx_record" {
  source   = "./modules/private_dns_mx_record"
  for_each = local.mx_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags
}

module "ptr_record" {
  source   = "./modules/private_dns_ptr_record"
  for_each = local.ptr_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = each.value.records
  tags      = each.value.tags
}

module "srv_record" {
  source   = "./modules/private_dns_srv_record"
  for_each = local.srv_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags
}

module "txt_record" {
  source   = "./modules/private_dns_txt_record"
  for_each = local.txt_records

  parent_id = azapi_resource.private_dns_zone.id
  name      = each.value.name
  ttl       = each.value.ttl
  records   = values(each.value.records)
  tags      = each.value.tags
}