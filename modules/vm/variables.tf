variable "prefix" {
  type        = string
  description = "The base name for the Virtual Machine"
}

variable "location" {
  type        = string
  description = "The location for the deployment"
}

variable "rg-name" {
  type        = string
  description = "Name of the resource group"
}

variable "size" {
  type        = string
  description = "SKU of the Virtual Machine"
}

variable "username" {
  type        = string
  description = "Default admin username for VM"
}

variable "nic" {
  description = "Network Interface card attached to VM"
}

variable "web-tls-public-key" {
}