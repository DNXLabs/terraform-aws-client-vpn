# terraform-aws-client-vpn

[![Lint Status](https://github.com/DNXLabs/terraform-aws-client-vpn/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-client-vpn/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-client-vpn)](https://github.com/DNXLabs/terraform-aws-client-vpn/blob/master/LICENSE)

This terraform module installs a client vpn.

The following resources will be created:
 - VPN Endpoint - Provides an AWS Client VPN endpoint for OpenVPN clients.
 - Provides network associations for AWS Client VPN endpoints
 - Generate AWS Certificate Manager(ACM) certificates

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| authentication\_saml\_provider\_arn | (Optional) The ARN of the IAM SAML identity provider if type is federated-authentication. | `any` | `null` | no |
| authentication\_type | The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0. | `string` | `"certificate-authentication"` | no |
| cidr | Network CIDR to use for clients | `any` | n/a | yes |
| dns_servers | List of DNS servers| `list(string)` | n/a | no |
| logs\_retention | Retention in days for CloudWatch Log Group | `number` | `365` | no |
| name | Name prefix for the resources of this stack | `any` | n/a | yes |
| organization\_name | Name of organization to use in private certificate | `string` | `"ACME, Inc"` | no |
| subnet\_ids | Subnet ID to associate clients | `list(string)` | n/a | yes |
| split_tunnel | Allow split tunnel connection | `bool` | `false` | no |
| tags | Extra tags to attach to resources | `map(string)` | `{}` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License
Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-client-vpn/blob/master/LICENSE) for full details.
