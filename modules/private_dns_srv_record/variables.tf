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

variable "records" {
  type = list(object({
    target   = string
    port     = number
    priority = number
    weight   = number
  }))
  description = "A list of SRV records, each with a target (host), port, priority, and weight."

  validation {
    condition     = alltrue([for r in var.records : can(regex("^([a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,}$", r.target)) && r.port > 0 && r.priority >= 0 && r.weight >= 0])
    error_message = "Each record must have a valid target hostname, a positive port, and non-negative priority and weight."
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
  default     = {}
  description = "A map of tags to assign to thedns record."

  validation {
    condition     = alltrue([for v in values(var.tags) : length(v) > 0])
    error_message = "All tag values must not be empty."
  }
}

variable "timeouts" {
  type = object({
    create = optional(string, "10m")
    update = optional(string, "10m")
    delete = optional(string, "10m")
  })
  default = {
    create = "10m"
    update = "10m"
    delete = "10m"
  }
  description = "Custom timeouts for the vdns record operations."

  validation {
    condition     = can(regex("^[0-9]+[sm]$", var.timeouts.create)) && can(regex("^[0-9]+[sm]$", var.timeouts.update)) && can(regex("^[0-9]+[sm]$", var.timeouts.delete))
    error_message = "Timeouts must be in the format of a number followed by 's' or 'm'."
  }
}
