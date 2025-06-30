variable "domain_name" {
  type        = string
  description = "The name of the private dns zone."
}

variable "parent_id" {
  type        = string
  description = "The ID of the parent resource. This is typically the ID of the resource group or a virtual network where the DNS zone will be created."

  validation {
    condition     = can(regex("^/subscriptions/[a-f0-9-]+/resourceGroups/[a-zA-Z0-9_.()-]+$", var.parent_id))
    error_message = "Must be a valid Azure resource ID containing '/subscriptions/' and '/resourceGroups/'"
  }
}

variable "a_records" {
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string))
    ip_addresses = optional(set(string), null)
    tags         = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a A record."

  validation {
    condition = alltrue([
      for k, v in var.a_records :
      coalescelist(v.ip_addresses, v.records)
    ])
    error_message = "Each A record must have either a non-empty records list or a non-empty ip_addresses set."
  }
}

variable "aaaa_records" {
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string))
    ip_addresses = optional(set(string), null)
    tags         = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a AAAA record."

  validation {
    condition = alltrue([
      for k, v in var.aaaa_records :
      coalescelist(v.ip_addresses, v.records)
    ])
    error_message = "Each AAAA record must have either a non-empty records list or a non-empty ip_addresses set."
  }
}

variable "cname_records" {
  type = map(object({
    name   = string
    ttl    = number
    record = optional(string, null)
    cname  = optional(string, null)
    tags   = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a CNAME record."

  validation {
    condition = alltrue([
      for k, v in var.cname_records :
      coalesce(v.cname, v.record)
    ])
    error_message = "Each CNAME record must have either a non-empty record or a non-empty cname value."
  }
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetryinfo.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "mx_records" {
  type = map(object({
    name = optional(string, "@")
    ttl  = number
    records = map(object({
      preference = number
      exchange   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a MX record."
}

variable "ptr_records" {
  type = map(object({
    name         = string
    ttl          = number
    records      = optional(list(string), null)
    domain_names = optional(set(string), null)
    tags         = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a PTR record."

  validation {
    condition = alltrue([
      for k, v in var.ptr_records :
      coalescelist(v.domain_names, v.records)
    ])
    error_message = "Each PTR record must have either a non-empty records list or a non-empty domain_names set."
  }
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
  A map of role assignments to create on the <RESOURCE>. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
  - `principal_id` - The ID of the principal to assign the role to.
  - `description` - (Optional) The description of the role assignment.
  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
  - `condition` - (Optional) The condition which will be used to scope the role assignment.
  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.
  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

  > Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
  DESCRIPTION
  nullable    = false
}

variable "soa_record" {
  type = object({
    email        = string
    name         = optional(string, "@")
    expire_time  = optional(number, 2419200)
    minimum_ttl  = optional(number, 10)
    refresh_time = optional(number, 3600)
    retry_time   = optional(number, 300)
    ttl          = optional(number, 3600)
    tags         = optional(map(string), null)
  })
  default     = null
  description = "optional soa_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com"
}

variable "srv_records" {
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      priority = number
      weight   = number
      port     = number
      target   = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a SRV record."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "timeouts" {
  type = object({
    dns_zones = optional(object({
      create = optional(string, "30m")
      delete = optional(string, "30m")
      update = optional(string, "30m")
      read   = optional(string, "5m")
      }), {}
    )
    vnet_links = optional(object({
      create = optional(string, "30m")
      delete = optional(string, "30m")
      update = optional(string, "30m")
      read   = optional(string, "5m")
      }), {}
    )
  })
  default = {
    dns_zones = {
      create = "30m"
      delete = "30m"
      update = "30m"
      read   = "5m"
    }
    vnet_links = {
      create = "30m"
      delete = "30m"
      update = "30m"
      read   = "5m"
    }
  }
  description = <<DESCRIPTION
A map of timeouts objects, per resource type, to apply to the creation and destruction of resources the following resources:

- `dns_zones` - (Optional) The timeouts for DNS Zones.
- `vnet_links` - (Optional) The timeouts for DNS Zones Virtual Network Links.

Each timeout object has the following optional attributes:

- `create` - (Optional) The timeout for creating the resource. Defaults to `5m` apart from policy assignments, where this is set to `15m`.
- `delete` - (Optional) The timeout for deleting the resource. Defaults to `5m`.
- `update` - (Optional) The timeout for updating the resource. Defaults to `5m`.
- `read` - (Optional) The timeout for reading the resource. Defaults to `5m`.

DESCRIPTION
}

variable "txt_records" {
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      value = list(string)
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a TXT record."
}

variable "virtual_network_links" {
  type = map(object({
    vnetlinkname         = optional(string, null)
    name                 = optional(string, null)
    vnetid               = optional(string, null)
    virtual_network_id   = optional(string, null)
    autoregistration     = optional(bool, false)
    registration_enabled = optional(bool, null)
    resolution_policy    = optional(string, "Default")
    tags                 = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a virtual network link. Either vnetlinkname or name must be provided, and either vnetid or virtual_network_id must be provided."

  validation {
    condition = alltrue([
      for k, v in var.virtual_network_links :
      coalesce(v.name, v.vnetlinkname)
    ])
    error_message = "Each virtual_network_link must have either vnetlinkname or name provided."
  }
  validation {
    condition = alltrue([
      for k, v in var.virtual_network_links :
      coalesce(v.virtual_network_id, v.vnetid)
    ])
    error_message = "Each virtual_network_link must have either vnetid or virtual_network_id provided."
  }
  validation {
    condition     = alltrue([for link in var.virtual_network_links : length(try(link.name, link.vnetlinkname)) < 80])
    error_message = "Each virtual network link name must have less than 80 characters."
  }
}
