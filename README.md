<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-syslog/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-syslog/actions/workflows/test.yml)

# Terraform ACI Syslog Module

Manages ACI Syslog

Location in GUI:
`Admin` » `External Data Collectors` » `Monitoring Destinations` » `Syslog`

## Examples

```hcl
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

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Syslog policy name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description. | `string` | `""` | no |
| <a name="input_format"></a> [format](#input\_format) | Format. Choices: `aci`, `nxos`. | `string` | `"aci"` | no |
| <a name="input_show_millisecond"></a> [show\_millisecond](#input\_show\_millisecond) | Show milliseconds. | `bool` | `false` | no |
| <a name="input_admin_state"></a> [admin\_state](#input\_admin\_state) | Admin state. | `bool` | `true` | no |
| <a name="input_local_admin_state"></a> [local\_admin\_state](#input\_local\_admin\_state) | Local admin state. | `bool` | `true` | no |
| <a name="input_local_severity"></a> [local\_severity](#input\_local\_severity) | Local severity. Choices: `emergencies`, `alerts`, `critical`, `errors`, `warnings`, `notifications`, `information`, `debugging`. | `string` | `"information"` | no |
| <a name="input_console_admin_state"></a> [console\_admin\_state](#input\_console\_admin\_state) | Console admin state. | `bool` | `true` | no |
| <a name="input_console_severity"></a> [console\_severity](#input\_console\_severity) | Console severity. Choices: `emergencies`, `alerts`, `critical`, `errors`, `warnings`, `notifications`, `information`, `debugging`. | `string` | `"alerts"` | no |
| <a name="input_destinations"></a> [destinations](#input\_destinations) | List of destinations. Allowed values `port`: 0-65535. Default value `port`: 514. Choices `format`: `aci`, `nxos`. Default value `format`: `aci`. Choices `facility`: `local0`, `local1` ,`local2` ,`local3` ,`local4` ,`local5`, `local6`, `local7`. Default value `facility`: `local7`. Choices `severity`: `emergencies`, `alerts`, `critical`, `errors`, `warnings`, `notifications`, `information`, `debugging`. Default value `severity`: `warnings`. | <pre>list(object({<br>    hostname_ip   = string<br>    port          = optional(number)<br>    admin_state   = optional(bool)<br>    format        = optional(string)<br>    facility      = optional(string)<br>    severity      = optional(string)<br>    mgmt_epg      = optional(string)<br>    mgmt_epg_name = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `syslogGroup` object. |
| <a name="output_name"></a> [name](#output\_name) | Syslog policy name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fileRsARemoteHostToEpg](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.syslogConsole](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.syslogFile](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.syslogGroup](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.syslogProf](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.syslogRemoteDest](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->