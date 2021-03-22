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
| cidr | Network CIDR to use for clients | `any` | n/a | yes |
| logs\_retention | Retention in days for CloudWatch Log Group | `number` | `365` | no |
| name | Name prefix for the resources of this stack | `any` | n/a | yes |
| organization\_name | Name of organization to use in private certificate | `string` | `"ACME, Inc"` | no |
| subnet\_cidrs | Subnet CIDR to associate clients | `list(string)` | n/a | yes |
| subnet\_ids | Subnet ID to associate clients | `list(string)` | n/a | yes |
| tags | Extra tags to attach to resources | `map(string)` | `{}` | no |

## Outputs

No output.

