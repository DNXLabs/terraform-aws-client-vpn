variable "name" {
  description = "Name prefix for the resources of this stack"
}

variable "cidr" {
  description = "Network CIDR to use for clients"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ID to associate clients (each subnet passed will create an VPN association - costs involved)"
}

variable "allowed_cidr_ranges" {
  type        = list(string)
  description = "List of CIDR ranges from which access is allowed"
  default     = []
}

variable "allowed_access_groups" {
  type        = list(string)
  description = "List of Access group IDs to allow access. Leave empty to allow all groups"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC Id to create resources"
}
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "List of DNS Servers"
}

variable "organization_name" {
  description = "Name of organization to use in private certificate"
  default     = "ACME, Inc"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to attach to resources"
}

variable "logs_retention" {
  default     = 365
  description = "Retention in days for CloudWatch Log Group"
}

variable "authentication_type" {
  default     = "certificate-authentication"
  description = "The type of client authentication to be used. Specify certificate-authentication to use certificate-based authentication, directory-service-authentication to use Active Directory authentication, or federated-authentication to use Federated Authentication via SAML 2.0."
}

variable "authentication_saml_provider_arn" {
  default     = null
  description = "(Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
}

variable "split_tunnel" {
  default     = true
  description = "With split_tunnel false, all client traffic will go through the VPN."
}

variable "security_group_id" {
  default     = ""
  description = "Optional security group id to use instead of the default created"
}

variable "enable_self_service_portal" {
  type        = bool
  default     = false
  description = "Specify whether to enable the self-service portal for the Client VPN endpoint"
}
