mock_provider "azapi" {
  mock_data "azapi_client_config" {
    defaults = {
      subscription_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000"
    }
  }
}

variables {
  ip_addresses = ["192.0.2.1"]
  name         = "example"
  parent_id    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/privateDnsZones/example.com"
  ttl          = 300
}

run "telemetry_disabled_without_location" {
  command = plan

  variables {
    enable_telemetry = false
  }

  assert {
    condition     = var.location == null && length(azapi_resource.telemetry) == 0
    error_message = "Disabling telemetry must allow an omitted location and create no telemetry deployment."
  }
}

run "telemetry_disabled_with_null_location" {
  command = plan

  variables {
    enable_telemetry = false
    location         = null
  }

  assert {
    condition     = var.location == null && length(azapi_resource.telemetry) == 0
    error_message = "Disabling telemetry must allow an explicitly null location."
  }
}

run "telemetry_enabled_with_location" {
  command = plan

  variables {
    location = "eastus"
  }

  assert {
    condition     = length(azapi_resource.telemetry) == 1 && azapi_resource.telemetry[0].location == "eastus"
    error_message = "Enabled telemetry must use the supplied location."
  }
}

run "telemetry_enabled_without_location" {
  command = plan

  expect_failures = [var.location]
}
