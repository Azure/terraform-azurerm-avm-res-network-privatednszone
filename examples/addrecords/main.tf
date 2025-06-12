module "addrecords" {
  source = "../../modules/addrecords"

  resource_group_name = local.resource_group_name
  # source = "Azure/terraform-azurerm-avm-res-network-privatednszone/azurerm//modules/addrecords"
  zone_name     = local.zone_name
  a_records     = local.a_records
  aaaa_records  = local.aaaa_records
  cname_records = local.cname_records
  mx_records    = local.mx_records
  ptr_records   = local.ptr_records
  srv_records   = local.srv_records
  txt_records   = local.txt_records
}