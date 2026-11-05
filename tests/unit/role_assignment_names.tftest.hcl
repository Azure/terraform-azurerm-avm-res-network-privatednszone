mock_provider "azapi" {
  override_during = plan

  mock_data "azapi_resource_list" {
    defaults = {
      output = {
        results = [{
          id        = "/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleDefinitions/22222222-2222-2222-2222-222222222222"
          role_name = "Reader"
        }]
      }
    }
  }
  mock_data "azapi_client_config" {
    defaults = {
      subscription_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000"
    }
  }
}

mock_provider "random" {
  override_during = plan

  mock_resource "random_uuid" {
    defaults = {
      result = "33333333-3333-4333-8333-333333333333"
    }
  }
}

mock_provider "time" {}

variables {
  domain_name      = "example.com"
  enable_telemetry = false
  parent_id        = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test"
  role_assignments = {
    reader = {
      principal_id               = "11111111-1111-1111-1111-111111111111"
      role_definition_id_or_name = "Reader"
    }
  }
}

run "random_name_by_default" {
  command = plan

  assert {
    condition     = azapi_resource.role_assignments["reader"].name == "33333333-3333-4333-8333-333333333333"
    error_message = "The default random role-assignment name must come from the Interfaces UUID resource."
  }
  providers = {
    azapi  = azapi
    random = random
    time   = time
  }
}

run "deterministic_name_when_disabled" {
  command = plan

  variables {
    role_assignment_name_use_random_uuid = false
  }

  assert {
    condition     = azapi_resource.role_assignments["reader"].name == "2cacdff0-6e14-52cb-8734-0ebfe85381fd"
    error_message = "Deterministic role-assignment names must use the principal and resolved role-definition ID."
  }
  providers = {
    azapi  = azapi
    random = random
    time   = time
  }
}
