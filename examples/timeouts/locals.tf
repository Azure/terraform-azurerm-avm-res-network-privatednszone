locals {
  a_records = {
    "a_record1" = {
      name         = "my_arecord1"
      ttl          = 300
      ip_addresses = ["10.1.1.1", "10.1.1.2"]
      tags = {
        "env" = "prod"
      }
    }

    "a_record2" = {
      name         = "my_arecord2"
      ttl          = 300
      ip_addresses = ["10.2.1.1", "10.2.1.2"]
      tags = {
        "env" = "dev"
      }
    }
  }
  aaaa_records = {
    "aaaa_record1" = {
      name         = "my_aaaarecord1"
      ttl          = 300
      ip_addresses = ["fd5d:70bc:930e:d008:0000:0000:0000:7334", "fd5d:70bc:930e:d008::7335"]
      tags = {
        "env" = "prod"
      }
    }

    "aaaa_record2" = {
      name         = "my_aaaarecord2"
      ttl          = 600
      ip_addresses = ["fd4d:70bc:930e:d008:0000:0000:0000:7334", "fd4d:70bc:930e:d008::7335"]
      tags = {
        "env" = "dev"
      }
    }
  }
  cname_records = {
    "cname_record1" = {
      name  = "my_cname1"
      ttl   = 300
      cname = "prod.testlab.io"
      tags = {
        "env" = "prod"
      }
    }

    "cname_record2" = {
      name  = "my_cname2"
      ttl   = 300
      cname = "dev.testlab.io"
      tags = {
        "env" = "dev"
      }
    }
  }
  domain_name      = "testlab.io"
  enable_telemetry = false
  mx_records = {
    "mx_record1" = {
      name = "primary"
      ttl  = 300
      records = {
        "record1" = {
          preference = 10
          exchange   = "mail1.testlab.io"
        }
        "record2" = {
          preference = 20
          exchange   = "mail2.testlab.io"
        }
      }
      tags = {
        "env" = "prod"
      }
    }

    "msx_record2" = {
      name = "backupmail"
      ttl  = 300
      records = {
        "record3" = {
          preference = 10
          exchange   = "backupmail1.testlab.io"
        }
        "record4" = {
          preference = 20
          exchange   = "backupmail2.testlab.io"
        }
      }
      tags = {
        "env" = "dev"
      }
    }
  }
  parent_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.avmrg.name}"
  ptr_records = {
    "ptr_record1" = {
      name         = "ptr1"
      ttl          = 300
      domain_names = ["web1.testlab.io", "web2.testlab.io"]
      tags = {
        "env" = "prod"
      }
    }

    "ptr_record2" = {
      name         = "ptr2"
      ttl          = 300
      domain_names = ["web1.testlab.io", "web2.testlab.io"]
      tags = {
        "env" = "dev"
      }
    }

  }
  soa_record = {
    email = "hostmaster.${local.domain_name}"
  }
  srv_records = {
    "srv_record1" = {
      name = "srv1"
      ttl  = 300
      records = {
        "srvrecordA" = {
          priority = 1
          weight   = 5
          port     = 8080
          target   = "targetA.testlab.io"
        }
        "srvrecordB" = {
          priority = 2
          weight   = 5
          port     = 8080
          target   = "targetB.testlab.io"
        }
      }
      tags = {
        "env" = "prod"
      }
    }

    "srv_record2" = {
      name = "srv2"
      ttl  = 300
      records = {
        "srvrecordC" = {
          priority = 3
          weight   = 5
          port     = 8080
          target   = "targetC.testlab.io"
        }
        "srvrecordD" = {
          priority = 4
          weight   = 5
          port     = 8080
          target   = "targetD.testlab.io"
        }
      }
      tags = {
        "env" = "dev"
      }
    }
  }
  tags = {
    environment = "test"
  }
  txt_records = {
    "txt_record1" = {
      name = "txt1"
      ttl  = 300
      records = {
        "txtrecordA" = {
          value = ["apple"]
        }
        "txtrecordB" = {
          value = ["banana"]
        }
      }
      tags = {
        "env" = "prod"
      }
    }

    "txt_record2" = {
      name = "txt2"
      ttl  = 300
      records = {
        "txtrecordC" = {
          value = ["orange"]
        }
        "txtrecordD" = {
          value = ["durian"]
        }
      }
      tags = {
        "env" = "prod"
      }
    }

  }
  virtual_network_links = {
    vnetlink1 = {
      name               = "vnetlink1"
      virtual_network_id = azurerm_virtual_network.this.id
      autoregistration   = true
      tags = {
        "env" = "prod"
      }
    }
  }
}
