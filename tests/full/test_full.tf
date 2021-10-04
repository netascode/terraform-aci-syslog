terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

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
    mgmt_epg_type = "oob"
    mgmt_epg_name = "OOB1"
  }]
}

data "aci_rest" "syslogGroup" {
  dn = "uni/fabric/slgroup-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "syslogGroup" {
  component = "syslogGroup"

  equal "name" {
    description = "name"
    got         = data.aci_rest.syslogGroup.content.name
    want        = module.main.name
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.syslogGroup.content.descr
    want        = "My Description"
  }

  equal "format" {
    description = "format"
    got         = data.aci_rest.syslogGroup.content.format
    want        = "nxos"
  }

  equal "includeMilliSeconds" {
    description = "includeMilliSeconds"
    got         = data.aci_rest.syslogGroup.content.includeMilliSeconds
    want        = "yes"
  }
}

data "aci_rest" "syslogRemoteDest" {
  dn = "${data.aci_rest.syslogGroup.id}/rdst-1.1.1.1"

  depends_on = [module.main]
}

resource "test_assertions" "syslogRemoteDest" {
  component = "syslogRemoteDest"

  equal "host" {
    description = "host"
    got         = data.aci_rest.syslogRemoteDest.content.host
    want        = "1.1.1.1"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.syslogRemoteDest.content.port
    want        = "1514"
  }

  equal "adminState" {
    description = "adminState"
    got         = data.aci_rest.syslogRemoteDest.content.adminState
    want        = "disabled"
  }

  equal "format" {
    description = "format"
    got         = data.aci_rest.syslogRemoteDest.content.format
    want        = "nxos"
  }

  equal "forwardingFacility" {
    description = "forwardingFacility"
    got         = data.aci_rest.syslogRemoteDest.content.forwardingFacility
    want        = "local1"
  }

  equal "severity" {
    description = "severity"
    got         = data.aci_rest.syslogRemoteDest.content.severity
    want        = "information"
  }
}

data "aci_rest" "fileRsARemoteHostToEpg" {
  dn = "${data.aci_rest.syslogRemoteDest.id}/rsARemoteHostToEpg"

  depends_on = [module.main]
}

resource "test_assertions" "fileRsARemoteHostToEpg" {
  component = "fileRsARemoteHostToEpg"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.fileRsARemoteHostToEpg.content.tDn
    want        = "uni/tn-mgmt/mgmtp-default/oob-OOB1"
  }
}

data "aci_rest" "syslogProf" {
  dn = "${data.aci_rest.syslogGroup.id}/prof"

  depends_on = [module.main]
}

resource "test_assertions" "syslogProf" {
  component = "syslogProf"

  equal "adminState" {
    description = "adminState"
    got         = data.aci_rest.syslogProf.content.adminState
    want        = "enabled"
  }
}

data "aci_rest" "syslogFile" {
  dn = "${data.aci_rest.syslogGroup.id}/file"

  depends_on = [module.main]
}

resource "test_assertions" "syslogFile" {
  component = "syslogFile"

  equal "adminState" {
    description = "adminState"
    got         = data.aci_rest.syslogFile.content.adminState
    want        = "disabled"
  }

  equal "format" {
    description = "format"
    got         = data.aci_rest.syslogFile.content.format
    want        = "nxos"
  }

  equal "severity" {
    description = "severity"
    got         = data.aci_rest.syslogFile.content.severity
    want        = "errors"
  }
}

data "aci_rest" "syslogConsole" {
  dn = "${data.aci_rest.syslogGroup.id}/console"

  depends_on = [module.main]
}

resource "test_assertions" "syslogConsole" {
  component = "syslogConsole"

  equal "adminState" {
    description = "adminState"
    got         = data.aci_rest.syslogConsole.content.adminState
    want        = "disabled"
  }

  equal "format" {
    description = "format"
    got         = data.aci_rest.syslogConsole.content.format
    want        = "nxos"
  }

  equal "severity" {
    description = "severity"
    got         = data.aci_rest.syslogConsole.content.severity
    want        = "critical"
  }
}
