locals {
  dns_ptr_records = [
    for domain_name in var.domain_names : {
      ptrdname = domain_name
    }
  ]
}
