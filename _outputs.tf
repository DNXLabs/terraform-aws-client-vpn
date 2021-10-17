output "security_group_id" {
  value = try(aws_security_group.default[0].id, var.security_group_id)
}
output "vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.default.id
}