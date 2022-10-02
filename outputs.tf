output "vm-ssh" {
    value = "Type this in on a terminal to SSH connection to web server: ssh -i ${module.local.filename} ${module.vm.username}@${module.vm.web-public-ip}"
}

output "vm-url" {
 value = "http://${module.vm.web-public-ip}/"
}

# output "webapp-url" {
#  value = "http://${module.webapp.webapp-name}.azurewebsites.net/"
# }