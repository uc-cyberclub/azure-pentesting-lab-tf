variable "prefix" {
  type        = string
  description = "The base name for the Virtual Network"
}

variable "location" {
  type        = string
  description = "The location for the deployment"
}

variable "vnet-cidr" {
  description = "The CIDR for the Virtual Network"

}

variable "subnet-cidr" {
  description = "The CIDR for the Subnet"
}

variable "rg-name" {
  type        = string
  description = "Name of the resource group"
}