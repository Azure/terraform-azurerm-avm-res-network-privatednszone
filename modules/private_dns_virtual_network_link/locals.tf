locals {
  private_dns_zone_body = {
    properties = {
      registrationEnabled = var.registration_enabled
      virtualNetwork = {
        id = var.virtual_network_id
      }
    }
  }
  private_link_dns_zone_body = {
    properties = {
      registrationEnabled = var.registration_enabled
      resolutionPolicy    = var.resolution_policy
      virtualNetwork = {
        id = var.virtual_network_id
      }
    }
  }
}
