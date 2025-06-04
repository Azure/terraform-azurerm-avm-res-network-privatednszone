output "virtual_network_link_outputs_deprecated" {
  description = "The virtual network link output"
  value = {
    for link_name, link in azurerm_private_dns_zone_virtual_network_link.this :
    link_name => {
      id = link.id
    }
  }
}
