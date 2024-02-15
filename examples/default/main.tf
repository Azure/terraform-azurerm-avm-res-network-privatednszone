module "private_dns_zones" {
  #source                = "./modules/private_dns_zones"
  #replace source with the correct link to the private_dns_zones module
  source                = "Azure/avm-res-network-privatednszone/azurerm"
  enable_telemetry      = local.enable_telemetry
  resource_group_name   = local.resource_group_name
  domain_name           = local.domain_name
  dns_zone_tags         = local.dns_zone_tags
  soa_record            = local.soa_record
  virtual_network_links = local.virtual_network_links
  a_records             = local.a_records
  aaaa_records          = local.aaaa_records
  cname_records         = local.cname_records
  mx_records            = local.mx_records
  ptr_records           = local.ptr_records
  srv_records           = local.srv_records
  txt_records           = local.txt_records
}