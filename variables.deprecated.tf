variable "use_depreacted_virtual_network_link_in_root_module" {
  type        = bool
  default     = false
  description = "Indicates whether the virtual network link is used in the root module. This is to enable backwards compatibility with existing configurations. The recommended approach is to specify moved blocks within your terraform configuration and migrate to the submodule."
}
