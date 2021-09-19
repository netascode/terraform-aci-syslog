output "dn" {
  value       = aci_rest.syslogGroup.id
  description = "Distinguished name of `syslogGroup` object."
}

output "name" {
  value       = aci_rest.syslogGroup.content.name
  description = "Syslog policy name."
}
