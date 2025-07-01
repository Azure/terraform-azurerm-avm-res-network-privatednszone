locals {
  dns_a_records = [
    for ip_address in var.ip_addresses : {
      ipv4Address    = ip_address
    }
  ]
}
