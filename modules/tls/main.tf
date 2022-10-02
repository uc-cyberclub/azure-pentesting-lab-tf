resource "tls_private_key" "web" {
  algorithm   = "RSA"
  ecdsa_curve = "4096"
}