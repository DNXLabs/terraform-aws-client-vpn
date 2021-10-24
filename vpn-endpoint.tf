resource "aws_ec2_client_vpn_endpoint" "default" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.cidr
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers

  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.root.arn
    saml_provider_arn          = var.authentication_saml_provider_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = merge(
    var.tags,
    tomap({
      "Name"    = "${var.name}-Client-VPN",
      "EnvName" = var.name
    })
  )
}

resource "aws_ec2_client_vpn_network_association" "default" {
  count                  = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  subnet_id              = element(var.subnet_ids, count.index)
  security_groups        = [var.security_group_id == "" ? aws_security_group.default[0].id : var.security_group_id]
}

resource "aws_ec2_client_vpn_authorization_rule" "all_groups" {
  count                  = length(var.allowed_access_groups) > 0 ? 0 : length(var.allowed_cidr_ranges)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = var.allowed_cidr_ranges[count.index]
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_authorization_rule" "specific_groups" {
  count                  = length(var.allowed_access_groups) * length(var.allowed_cidr_ranges)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  target_network_cidr    = element(var.allowed_cidr_ranges, count.index)
  access_group_id        = var.allowed_access_groups[count.index % length(var.allowed_cidr_ranges)]
}
