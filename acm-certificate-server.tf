resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.server.private_key_pem

  subject {
    common_name  = "${var.name}.vpn.server"
    organization = var.organization_name
  }
}

resource "tls_locally_signed_cert" "server" {
  cert_request_pem   = tls_cert_request.server.cert_request_pem
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = 87600

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "server" {
  private_key       = tls_private_key.server.private_key_pem
  certificate_body  = tls_locally_signed_cert.server.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}
