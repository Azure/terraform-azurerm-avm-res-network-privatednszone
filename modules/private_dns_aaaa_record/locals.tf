locals {
  dns_aaaa_records = [
    for ip_address in var.ip_addresses : {
      ipv6Address = ip_address
    }
  ]
}
