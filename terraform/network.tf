#Create the ret that will hold the subnet used by vms
resource "azurerm_virtual_network" "Vnet-cp2" {
  name                = "vnetcp2"
  address_space       = ["${var.vnet_slash_16}.0.0/16"]
  location            = azurerm_resource_group.devops-cp2-group.location
  resource_group_name = azurerm_resource_group.devops-cp2-group.name

  tags = {
    environment = "CP2"
  }
}

#Subnet inside previous vnet
resource "azurerm_subnet" "Subnet-cp2" {
  name                   = "subnetcp2"
  resource_group_name    = azurerm_resource_group.devops-cp2-group.name
  virtual_network_name   = azurerm_virtual_network.Vnet-cp2.name
  address_prefixes       = ["${var.vsubnet_slash_24}.0/24"]
}

#Creating public ips
resource "azurerm_public_ip" "publicips" {
  for_each = var.containers

  name                = "vmip_${each.key}"
  location            = azurerm_resource_group.devops-cp2-group.location
  resource_group_name = azurerm_resource_group.devops-cp2-group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = {
    environment = "CP2"
  }
}

#Create network cards for every VM
resource "azurerm_network_interface" "nics" {
  for_each = var.containers

  name                = "vnic_${each.key}"
  location            = azurerm_resource_group.devops-cp2-group.location
  resource_group_name = azurerm_resource_group.devops-cp2-group.name

  ip_configuration {
    name                           = "ipconfig_${each.key}"
    subnet_id                      = azurerm_subnet.Subnet-cp2.id
    private_ip_address_allocation  = "Static"
    private_ip_address             = "${var.vsubnet_slash_24}.${each.value.id}"
    public_ip_address_id           = azurerm_public_ip.publicips[each.key].id
  }

  tags = {
    environment = "CP2"
  }
}