resource "local_file" "web-server-key" {
    filename = "webkey_private.pem"
    file_permission = 0400
    content  = var.web-tls-private-key
}