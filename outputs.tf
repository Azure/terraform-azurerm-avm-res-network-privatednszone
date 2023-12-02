# TODO: insert outputs here.
output "private_dnz_zone_output" {
  value = azurerm_private_dns_zone.example
}


output "a_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_a_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "aaaa_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_aaaa_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}


output "virtual_network_link_outputs" {
  value = {
    for link_name, link in azurerm_private_dns_zone_virtual_network_link.example :
    link_name => {
      id = link.id
    }
  }
}

output "cname_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_cname_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "mx_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_mx_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "ptr_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_ptr_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "srv_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_srv_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "txt_record_outputs" {
  value = {
    for record_name, record in azurerm_private_dns_txt_record.example :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}