output "a_record_outputs" {
  description = "The a record output"
  value = {
    for record_name, record in azurerm_private_dns_a_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value = {
    for record_name, record in azurerm_private_dns_aaaa_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "cname_record_outputs" {
  description = "The cname record output"
  value = {
    for record_name, record in azurerm_private_dns_cname_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "mx_record_outputs" {
  description = "The mx record output"
  value = {
    for record_name, record in azurerm_private_dns_mx_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value = {
    for record_name, record in azurerm_private_dns_ptr_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "resource_id" {
  description = "Added to comply with required_output_rmfr7"
  value       = null
}

output "srv_record_outputs" {
  description = "The srv record output"
  value = {
    for record_name, record in azurerm_private_dns_srv_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}

output "txt_record_outputs" {
  description = "The txt record output"
  value = {
    for record_name, record in azurerm_private_dns_txt_record.this :
    record_name => {
      id   = record.id
      fqdn = record.fqdn
    }
  }
}
