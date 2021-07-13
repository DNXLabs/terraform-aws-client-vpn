variable "name" {
  description = "Name prefix for the resources of this stack"
}

variable "cidr" {
  description = "Network CIDR to use for clients"
}
variable "split_tunnel" {
  description = "Allow split tunnel"
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet ID to associate clients"
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
  description = " (Optional) The ARN of the IAM SAML identity provider if type is federated-authentication."
}
