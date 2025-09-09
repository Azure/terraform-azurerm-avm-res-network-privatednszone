variable "cname" {
  type        = string
  description = "CNAME (FQDN), strict DNS rules; trailing dot optional."

  validation {
    condition = can(
      regex(
        "^(?:[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)(?:\\.(?:[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?))+\\.?$",
        var.cname
      )
    ) && length(replace(var.cname, "\\.$", "")) <= 253

    error_message = "The CNAME must be a valid DNS name, optionally ending with a trailing dot, and must not exceed 253 characters (e.g. abc.com or abc.com.)."
  }
}



variable "name" {
  type        = string
  description = "The name of the dns record."

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

variable "ttl" {
  type        = number
  description = "The time to live of the record."

  validation {
    condition     = var.ttl > 0
    error_message = "The ttl must be greater than 0."
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
  description = "Custom timeouts for the vdns record operations."

  validation {
    condition     = can(regex("^[0-9]+[sm]$", var.timeouts.create)) && can(regex("^[0-9]+[sm]$", var.timeouts.update)) && can(regex("^[0-9]+[sm]$", var.timeouts.delete))
    error_message = "Timeouts must be in the format of a number followed by 's' or 'm'."
  }
}
