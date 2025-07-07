variable "name" {
  type        = string
  description = "The name of the virtual network link."

  validation {
    condition     = length(var.name) > 0
    error_message = "The name must not be empty."
  }
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent resource to which this virtual network link belongs."

  validation {
    condition     = length(var.parent_id) > 0
    error_message = "The parent_id must not be empty."
  }
  validation {
    condition     = can(regex("^/subscriptions/[a-fA-F0-9-]+/resourceGroups/[a-zA-Z0-9-_.()]+/providers/Microsoft.Network/privateDnsZones/[a-zA-Z0-9-_.]+$", var.parent_id))
    error_message = "The parent_id must be a valid Azure Private DNS Zone resource ID."
  }
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the virtual network to link to the private DNS zone."

  validation {
    condition     = length(var.virtual_network_id) > 0
    error_message = "The virtual_network_id must not be empty."
  }
  validation {
    condition     = can(regex("^/subscriptions/[a-fA-F0-9-]+/resourceGroups/[a-zA-Z0-9-_.()]+/providers/Microsoft.Network/virtualNetworks/[a-zA-Z0-9-_.]+$", var.virtual_network_id))
    error_message = "The virtual_network_id must be a valid Azure Virtual Network resource ID."
  }
}

variable "private_dns_zone_supports_private_link" {
  type        = bool
  default     = false
  description = "Indicates whether the private DNS zone supports private link."
}

variable "registration_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether the virtual network link allows automatic registration of virtual machine DNS records in the private DNS zone."
}

variable "resolution_policy" {
  type        = string
  default     = "Default"
  description = "The Azure private link zone resolution policy for the virtual network link. Possible values are 'Default' or 'NxDomainRedirect'. If the private DNS zone is not an Azure private link zone (e.g. privatelink.blob.core.windows.net), this value is ignored."

  validation {
    condition     = contains(["Default", "NxDomainRedirect"], var.resolution_policy)
    error_message = "The resolution_policy must be either 'Default' or 'NxDomainRedirect'."
  }
}

variable "retry" {
  type = object({
    error_message_regex  = optional(list(string), ["ReferencedResourceNotProvisioned", "CannotDeleteResource"])
    interval_seconds     = optional(number, 10)
    max_interval_seconds = optional(number, 180)
    multiplier           = optional(number, 1.5)
    randomization_factor = optional(number, 0.5)
  })
  default     = {}
  description = "Retry configuration for the resource operations"
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "timeouts" {
  type = object({
    create = optional(string, "10m")
    update = optional(string, "10m")
    read   = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default = {
    create = "10m"
    read   = "10m"
    update = "10m"
    delete = "10m"
  }
  description = "Custom timeouts for the virtual network link operations."

  validation {
    condition     = can(regex("^[0-9]+[sm]$", var.timeouts.create)) && can(regex("^[0-9]+[sm]$", var.timeouts.update)) && can(regex("^[0-9]+[sm]$", var.timeouts.delete))
    error_message = "Timeouts must be in the format of a number followed by 's' or 'm'."
  }
}
