resource "aws_ec2_client_vpn_endpoint" "default" {
  description            = "${var.name}-Client-VPN"
  server_certificate_arn = aws_acm_certificate.server.arn
  client_cidr_block      = var.cidr
  split_tunnel           = var.split_tunnel
  dns_servers            = var.dns_servers
  self_service_portal    = local.self_service_portal
  security_group_ids     = [var.security_group_id == "" ? aws_security_group.default[0].id : var.security_group_id]
  vpc_id                 = var.vpc_id

  authentication_options {
    type                       = var.authentication_type
    root_certificate_chain_arn = var.authentication_type != "certificate-authentication" ? null : aws_acm_certificate.root.arn
    saml_provider_arn          = var.authentication_saml_provider_arn
    self_service_saml_provider_arn  = var.enable_self_service_portal == true ? var.self_service_saml_provider_arn : null
    active_directory_id        = var.active_directory_id
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = aws_cloudwatch_log_group.vpn.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  client_connect_options {
    enabled             = var.client_connect_options
    lambda_function_arn = var.client_connect_options != true ? null : var.connection_authorization_lambda_function_arn
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


resource "aws_ec2_client_vpn_route" "default" {
  count                  = length(var.subnet_ids) * length(var.allowed_cidr_ranges) 
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
  destination_cidr_block = element(var.allowed_cidr_ranges, count.index)
  target_vpc_subnet_id   = var.subnet_ids[count.index % length(var.subnet_ids)] 
}