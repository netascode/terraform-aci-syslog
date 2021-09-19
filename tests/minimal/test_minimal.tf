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

  name = "SYSLOG1"
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
}
