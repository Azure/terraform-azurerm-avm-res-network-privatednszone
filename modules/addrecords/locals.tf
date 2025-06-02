locals {
  parent_resource_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/privateDnsZones/${var.zone_name}"
}

# Block for DNS record variables
locals {
  a_records = {
    for record in var.a_records : "A/${record.name}" => {
      ttl     = record.ttl
      records = record.records
      tags    = lookup(record, "tags", null)
    }
  }
  aaaa_records = {
    for record in var.aaaa_records : "AAAA/${record.name}" => {
      ttl     = record.ttl
      records = record.records
      tags    = lookup(record, "tags", null)
    }
  }
  cname_records = {
    for record in var.cname_records : "CNAME/${record.name}" => {
      ttl    = record.ttl
      record = record.record
      tags   = lookup(record, "tags", null)
    }
  }
  dns_record_property_names = {
    SOA   = "soaRecord"
    A     = "aRecords"
    AAAA  = "aaaaRecords"
    CNAME = "cnameRecord"
    MX    = "mxRecords"
    PTR   = "ptrRecords"
    SRV   = "srvRecords"
    TXT   = "txtRecords"
  }
  dns_records_by_type = merge(
    local.a_records,
    local.aaaa_records,
    local.cname_records,
    local.mx_records,
    local.ptr_records,
    local.srv_records,
    local.txt_records
  )
  mx_records = {
    for record in var.mx_records : "MX/${record.name}" => {
      ttl  = record.ttl
      tags = lookup(record, "tags", null)
      records = [for mx_k, mx_v in record.records : {
        preference = mx_v.preference
        exchange   = mx_v.exchange
      }]
    }
  }
  ptr_records = {
    for record in var.ptr_records : "PTR/${record.name}" => {
      ttl     = record.ttl
      records = record.records
      tags    = lookup(record, "tags", null)
    }
  }
  srv_records = {
    for record in var.srv_records : "SRV/${record.name}" => {
      ttl  = record.ttl
      tags = lookup(record, "tags", null)
      records = [for srv_k, srv_v in record.records : {
        priority = srv_v.priority
        weight   = srv_v.weight
        port     = srv_v.port
        target   = srv_v.target
      }]
    }
  }
  txt_records = {
    for record in var.txt_records : "TXT/${record.name}" => {
      ttl  = record.ttl
      tags = lookup(record, "tags", null)
      records = [
        for txt_k, txt_v in record.records : {
          value = txt_v.value
        }
      ]
    }
  }
}
