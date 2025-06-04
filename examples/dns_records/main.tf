# create the resource group
resource "azurerm_resource_group" "avmrg" {
  location = "EastUS"
  name     = "avmrg"
}

module "private_dns_zone" {
  # replace source with the correct link to the private_dns_zones module
  # source                = "Azure/avm-res-network-privatednszone/azurerm"  
  source = "../../"

  domain_name         = local.domain_name
  resource_group_name = azurerm_resource_group.avmrg.name
  subscription_id     = var.subscription_id
}

module "a_record" {
  source   = "../../modules/private_dns_a_record"
  for_each = local.a_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "aaaa_record" {
  source   = "../../modules/private_dns_aaaa_record"
  for_each = local.aaaa_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "cname_record" {
  source   = "../../modules/private_dns_cname_record"
  for_each = local.cname_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  record    = each.value.record
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "mx_record" {
  source   = "../../modules/private_dns_mx_record"
  for_each = local.mx_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "ptr_record" {
  source   = "../../modules/private_dns_ptr_record"
  for_each = local.ptr_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = each.value.records
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "srv_record" {
  source   = "../../modules/private_dns_srv_record"
  for_each = local.srv_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}

module "txt_record" {
  source   = "../../modules/private_dns_txt_record"
  for_each = local.txt_records

  name      = each.value.name
  parent_id = module.private_dns_zone.resource_id
  records   = values(each.value.records)
  ttl       = each.value.ttl
  tags      = each.value.tags
}