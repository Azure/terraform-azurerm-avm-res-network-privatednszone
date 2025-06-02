variable "subscription_id" {
  type        = string
  nullable    = false
  default     = ""
  description = "An existing subscription id that should be a GUID in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. All letters must be lowercase."
  validation {
    condition     = can(regex("^[a-f\\d]{4}(?:[a-f\\d]{4}-){4}[a-f\\d]{12}$", var.subscription_id))
    error_message = "Must a GUID in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. All letters must be lowercase."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The resource group of the private DNS zone."
}

variable "zone_name" {
  type        = string
  description = "The name of the private DNS zone."
}

variable "a_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a A record."
}

variable "aaaa_records" {
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a AAAA record."
}

variable "cname_records" {
  type = map(object({
    name   = string
    ttl    = number
    record = string
    tags   = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a CNAME record."
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
    name    = string
    ttl     = number
    records = list(string)
    tags    = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a PTR record."
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

variable "txt_records" {
  type = map(object({
    name = string
    ttl  = number
    records = map(object({
      value = string
    }))
    tags = optional(map(string), null)
  }))
  default     = {}
  description = "A map of objects where each object contains information to create a TXT record."
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
  })
  default     = {}
  description = <<DESCRIPTION
A map of timeouts objects, per resource type, to apply to the creation and destruction of resources the following resources:

- `dns_zones` - (Optional) The timeouts for DNS Zones.

Each timeout object has the following optional attributes:

- `create` - (Optional) The timeout for creating the resource. Defaults to `5m` apart from policy assignments, where this is set to `15m`.
- `delete` - (Optional) The timeout for deleting the resource. Defaults to `5m`.
- `update` - (Optional) The timeout for updating the resource. Defaults to `5m`.
- `read` - (Optional) The timeout for reading the resource. Defaults to `5m`.

DESCRIPTION
}