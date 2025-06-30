variable "email" {
  type        = string
  description = "The email address of the SOA record."

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+(\\.[a-zA-Z0-9-]+)+$", var.email))
    error_message = "The SOA email must be in DNS format, like 'hostmaster.example.com' (dot instead of @, no trailing dot, and no requirement for numbers)."
  }
}

variable "expire_time" {
  type        = number
  description = "The expiration time of the SOA record in seconds."

  validation {
    condition     = var.expire_time > 0
    error_message = "The expire_time must be greater than 0."
  }
}

variable "minimum_ttl" {
  type        = number
  description = "The minimum time to live of the record in seconds."

  validation {
    condition     = var.minimum_ttl >= 0
    error_message = "The minimum_ttl must be greater than or equal to 0."
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

variable "refresh_time" {
  type        = number
  description = "The refresh time of the SOA record in seconds."

  validation {
    condition     = var.refresh_time > 0
    error_message = "The refresh_time must be greater than 0."
  }
}

variable "retry_time" {
  type        = number
  description = "The retry time of the SOA record in seconds."

  validation {
    condition     = var.retry_time > 0
    error_message = "The retry_time must be greater than 0."
  }
}

variable "ttl" {
  type        = number
  description = "The time to live of the record in seconds."

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
