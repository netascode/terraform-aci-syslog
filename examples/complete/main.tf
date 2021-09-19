module "aci_syslog" {
  source  = "netascode/syslog/aci"
  version = ">= 0.0.1"

  name                = "SYSLOG1"
  description         = "My Description"
  format              = "nxos"
  show_millisecond    = true
  admin_state         = true
  local_admin_state   = false
  local_severity      = "errors"
  console_admin_state = false
  console_severity    = "critical"
  destinations = [{
    hostname_ip   = "1.1.1.1"
    port          = 1514
    admin_state   = false
    format        = "nxos"
    facility      = "local1"
    severity      = "information"
    mgmt_epg      = "oob"
    mgmt_epg_name = "OOB1"
  }]
}
