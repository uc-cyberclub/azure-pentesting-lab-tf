# Provides Virtual Network 
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = var.location
  address_space       = var.vnet-cidr
  resource_group_name = var.rg-name
}

# Provides internal subnet within the Virtual Network for VM
resource "azurerm_subnet" "sn" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet-cidr
}

# Provides a Public IP for NIC assigned to Web Server VM
resource "azurerm_public_ip" "web" {
  name                = "${var.prefix}-web-public-ip"
  resource_group_name = var.rg-name
  location            = var.location
  allocation_method   = "Dynamic"
}

# Provides NIC for VM to connect to internal subnet
resource "azurerm_network_interface" "web" {
  name                = "${var.prefix}-web-nic"
  location            = var.location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web.id
  }
}

# Provides Network Security Group and Rules to allow web traffic (TCP 80 & 443)
resource "azurerm_network_security_group" "web" {
  name                = "${var.prefix}-web-sg"
  location            = var.location
  resource_group_name = var.rg-name
}

resource "azurerm_network_security_rule" "http" {
  name                        = "${var.prefix}-http-sg-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg-name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_network_security_rule" "https" {
  name                        = "${var.prefix}-https-sg-rule"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg-name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "${var.prefix}-ssh-sg-rule"
  priority                    = 300
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg-name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_network_interface_security_group_association" "web" {
  network_interface_id      = azurerm_network_interface.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}