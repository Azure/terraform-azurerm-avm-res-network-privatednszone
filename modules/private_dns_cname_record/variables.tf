variable "cname" {
  type        = string
  description = "The CNAME record value."

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-_.]*[a-zA-Z0-9]$", var.cname)) && length(var.cname) <= 253
    error_message = "The cname must be a valid CNAME and not exceed 253 characters."
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
  description = "Custom timeouts for the vdns record operations."

  validation {
    condition     = can(regex("^[0-9]+[sm]$", var.timeouts.create)) && can(regex("^[0-9]+[sm]$", var.timeouts.update)) && can(regex("^[0-9]+[sm]$", var.timeouts.delete))
    error_message = "Timeouts must be in the format of a number followed by 's' or 'm'."
  }
}
