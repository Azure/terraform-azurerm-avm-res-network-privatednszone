enable_telemetry    = false
resource_group_name = "testrg"
# resource_group_location = "eastus"
domain_name = "testlab.io"

dns_zone_tags = {
  "env" = "prod"
}

# optional soa_record variable, if included only email is required, rest are optional. Email must use username.corp.com and not username@corp.com
soa_record = {
  email        = "admin.testlab.io"
  refresh_time = 1800
}

# a map of objects where each object contains information to create virtual network link
virtual_network_links = {
  vnetlink1 = {
    vnetlinkname     = "vnetlink1"
    vnetid           = "/subscriptions/68be2809-9674-447c-a43d-261ef2862c29/resourceGroups/testrg/providers/Microsoft.Network/virtualNetworks/testvnet1"
    autoregistration = true
    tags = {
      "env" = "prod"
    }
  }
  vnetlink2 = {
    vnetlinkname     = "vnetlink2"
    vnetid           = "/subscriptions/68be2809-9674-447c-a43d-261ef2862c29/resourceGroups/testrg/providers/Microsoft.Network/virtualNetworks/testvnet2"
    autoregistration = false
    tags = {
      "env" = "dev"
    }
  }
}


a_records = {
  "a_record1" = {
    name                = "my_arecord1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records             = ["10.1.1.1", "10.1.1.2"]
    tags = {
      "env" = "prod"
    }
  }

  "a_record2" = {
    name                = "my_arecord2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records             = ["10.2.1.1", "10.2.1.2"]
    tags = {
      "env" = "dev"
    }
  }
}


aaaa_records = {
  "aaaa_record1" = {
    name                = "my_aaaarecord1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records             = ["fd5d:70bc:930e:d008:0000:0000:0000:7334", "fd5d:70bc:930e:d008::7335"]
    tags = {
      "env" = "prod"
    }
  }

  "aaaa_record2" = {
    name                = "my_aaaarecord2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 600
    records             = ["fd4d:70bc:930e:d008:0000:0000:0000:7334", "fd4d:70bc:930e:d008::7335"]
    tags = {
      "env" = "dev"
    }
  }
}

cname_records = {
  "cname_record1" = {
    name                = "my_cname1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    record              = "prod.testlab.io"
    tags = {
      "env" = "prod"
    }
  }

  "cname_record2" = {
    name                = "my_cname2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    record              = "dev.testlab.io"
    tags = {
      "env" = "dev"
    }
  }
}


mx_records = {
  "mx_record1" = {
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
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
    name                = "backupmail"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
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


ptr_records = {
  "ptr_record1" = {
    name                = "ptr1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records             = ["web1.testlab.io", "web2.testlab.io"]
    tags = {
      "env" = "prod"
    }
  }

  "ptr_record2" = {
    name                = "ptr2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records             = ["web1.testlab.io", "web2.testlab.io"]
    tags = {
      "env" = "dev"
    }
  }

}


srv_records = {
  "srv_record1" = {
    name                = "srv1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
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
    name                = "srv2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
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

txt_records = {
  "txt_record1" = {
    name                = "txt1"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records = {
      "txtrecordA" = {
        value = "apple"
      }
      "txtrecordB" = {
        value = "banana"
      }
    }
    tags = {
      "env" = "prod"
    }
  }

  "txt_record2" = {
    name                = "txt2"
    resource_group_name = "testrg"
    zone_name           = "testlab.io"
    ttl                 = 300
    records = {
      "txtrecordC" = {
        value = "orange"
      }
      "txtrecordD" = {
        value = "durian"
      }
    }
    tags = {
      "env" = "prod"
    }
  }

}

