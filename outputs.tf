output "a_record_outputs" {
  description = "The a record output"
  value = {
    for record_name, record in module.a_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "aaaa_record_outputs" {
  description = "The aaaa record output"
  value = {
    for record_name, record in module.aaaa_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "cname_record_outputs" {
  description = "The cname record output"
  value = {
    for record_name, record in module.cname_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "mx_record_outputs" {
  description = "The mx record output"
  value = {
    for record_name, record in module.mx_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "name" {
  description = "The name of private DNS zone"
  value       = azapi_resource.private_dns_zone.output.name
}

output "ptr_record_outputs" {
  description = "The ptr record output"
  value = {
    for record_name, record in module.ptr_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "resource" {
  description = "The private dns zone output"
  value       = azapi_resource.private_dns_zone.output
}

output "resource_id" {
  description = "The resource id of private DNS zone"
  value       = azapi_resource.private_dns_zone.id
}

output "soa_record_outputs" {
  description = "The srv record output"
  value = {
    for record in module.srv_record :
    default => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "srv_record_outputs" {
  description = "The srv record output"
  value = {
    for record_name, record in module.srv_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "txt_record_outputs" {
  description = "The txt record output"
  value = {
    for record_name, record in module.txt_record :
    record_name => {
      id   = record.resource_id
      fqdn = record.resource.fqdn
    }
  }
}

output "virtual_network_link_outputs" {
  description = "The virtual network link output"
  value = {
    for link_name, link in module.virtual_network_links :
    link_name => {
      id = link.resource_id
    }
  }
}
