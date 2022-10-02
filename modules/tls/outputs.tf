output "web-tls-private-key" {
    value = tls_private_key.web.private_key_pem
}

output "web-tls-public-key" {
    value = tls_private_key.web.public_key_openssh
}