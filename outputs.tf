output "a_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_a_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The a record output"
}

output "aaaa_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_aaaa_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The aaaa record output"
}

output "cname_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_cname_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The cname record output"
}

output "mx_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_mx_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The mx record output"
}

output "private_dnz_zone_output" {
  value       = azurerm_private_dns_zone.example
  description = "The private dns zone output"
}

output "ptr_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_ptr_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The ptr record output"
}

output "srv_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_srv_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The srv record output"
}

output "txt_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_txt_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
  description = "The txt record output"
}

output "virtual_network_link_outputs" {
  value = {
    for link_name, link in azurerm_private_dns_zone_virtual_network_link.example :
    link_name => {
      id = link.id
    }
  }
  description = "The virtual network link output"
}