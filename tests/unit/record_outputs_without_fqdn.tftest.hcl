# A record set read back without `properties` (as seen during `terraform import`, see #215)
# has no `fqdn` in its exported output. The root module's record outputs must still evaluate.

mock_provider "azapi" {
  override_during = plan
}

mock_provider "random" {
  override_during = plan
}

mock_provider "time" {}

variables {
  domain_name      = "example.internal"
  enable_telemetry = false
  parent_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg"
}

run "a_record_output_without_fqdn" {
  command = plan

  variables {
    a_records = {
      example = {
        name    = "example"
        ttl     = 3600
        records = ["192.0.2.10"]
      }
    }
  }

  override_resource {
    target          = module.a_record["example"].azapi_resource.a_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/A/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/A/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/A"
      }
    }
  }

  assert {
    condition     = output.a_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/A/example"
    error_message = "The A record output must keep the record ID."
  }

  assert {
    condition     = output.a_record_outputs["example"].fqdn == null
    error_message = "The A record output must report a null fqdn when the record output has none."
  }
}

run "aaaa_record_output_without_fqdn" {
  command = plan

  variables {
    aaaa_records = {
      example = {
        name    = "example"
        ttl     = 3600
        records = ["2001:db8::10"]
      }
    }
  }

  override_resource {
    target          = module.aaaa_record["example"].azapi_resource.aaaa_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/AAAA/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/AAAA/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/AAAA"
      }
    }
  }

  assert {
    condition     = output.aaaa_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/AAAA/example"
    error_message = "The AAAA record output must keep the record ID."
  }

  assert {
    condition     = output.aaaa_record_outputs["example"].fqdn == null
    error_message = "The AAAA record output must report a null fqdn when the record output has none."
  }
}

run "cname_record_output_without_fqdn" {
  command = plan

  variables {
    cname_records = {
      example = {
        name   = "example"
        ttl    = 3600
        record = "target.example.internal"
      }
    }
  }

  override_resource {
    target          = module.cname_record["example"].azapi_resource.cname_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/CNAME/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/CNAME/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/CNAME"
      }
    }
  }

  assert {
    condition     = output.cname_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/CNAME/example"
    error_message = "The CNAME record output must keep the record ID."
  }

  assert {
    condition     = output.cname_record_outputs["example"].fqdn == null
    error_message = "The CNAME record output must report a null fqdn when the record output has none."
  }
}

run "mx_record_output_without_fqdn" {
  command = plan

  variables {
    mx_records = {
      example = {
        name = "example"
        ttl  = 3600
        records = {
          primary = {
            preference = 10
            exchange   = "mail.example.internal"
          }
        }
      }
    }
  }

  override_resource {
    target          = module.mx_record["example"].azapi_resource.mx_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/MX/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/MX/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/MX"
      }
    }
  }

  assert {
    condition     = output.mx_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/MX/example"
    error_message = "The MX record output must keep the record ID."
  }

  assert {
    condition     = output.mx_record_outputs["example"].fqdn == null
    error_message = "The MX record output must report a null fqdn when the record output has none."
  }
}

run "ptr_record_output_without_fqdn" {
  command = plan

  variables {
    ptr_records = {
      example = {
        name    = "example"
        ttl     = 3600
        records = ["host.example.internal"]
      }
    }
  }

  override_resource {
    target          = module.ptr_record["example"].azapi_resource.ptr_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/PTR/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/PTR/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/PTR"
      }
    }
  }

  assert {
    condition     = output.ptr_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/PTR/example"
    error_message = "The PTR record output must keep the record ID."
  }

  assert {
    condition     = output.ptr_record_outputs["example"].fqdn == null
    error_message = "The PTR record output must report a null fqdn when the record output has none."
  }
}

run "srv_record_output_without_fqdn" {
  command = plan

  variables {
    srv_records = {
      example = {
        name = "_sip._tcp"
        ttl  = 3600
        records = {
          primary = {
            priority = 10
            weight   = 5
            port     = 5060
            target   = "sip.example.internal"
          }
        }
      }
    }
  }

  override_resource {
    target          = module.srv_record["example"].azapi_resource.srv_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/SRV/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/SRV/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/SRV"
      }
    }
  }

  assert {
    condition     = output.srv_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/SRV/example"
    error_message = "The SRV record output must keep the record ID."
  }

  assert {
    condition     = output.srv_record_outputs["example"].fqdn == null
    error_message = "The SRV record output must report a null fqdn when the record output has none."
  }
}

run "txt_record_output_without_fqdn" {
  command = plan

  variables {
    txt_records = {
      example = {
        name = "example"
        ttl  = 3600
        records = {
          primary = {
            value = ["hello"]
          }
        }
      }
    }
  }

  override_resource {
    target          = module.txt_record["example"].azapi_resource.txt_record
    override_during = plan
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/TXT/example"
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/TXT/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/TXT"
      }
    }
  }

  assert {
    condition     = output.txt_record_outputs["example"].id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/TXT/example"
    error_message = "The TXT record output must keep the record ID."
  }

  assert {
    condition     = output.txt_record_outputs["example"].fqdn == null
    error_message = "The TXT record output must report a null fqdn when the record output has none."
  }
}

run "a_record_output_with_fqdn" {
  command = plan

  variables {
    a_records = {
      example = {
        name    = "example"
        ttl     = 3600
        records = ["192.0.2.10"]
      }
    }
  }

  override_resource {
    target          = module.a_record["example"].azapi_resource.a_record
    override_during = plan
    values = {
      output = {
        id   = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/privateDnsZones/example.internal/A/example"
        name = "example"
        type = "Microsoft.Network/privateDnsZones/A"
        fqdn = "example.example.internal."
        ttl  = 3600
      }
    }
  }

  assert {
    condition     = output.a_record_outputs["example"].fqdn == "example.example.internal."
    error_message = "The A record output must pass the fqdn through when it is present."
  }
}
