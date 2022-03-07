resource "azurerm_linux_virtual_machine" "vms" {
  for_each = var.containers

  name                            = "cp2vm_${each.key}"
  resource_group_name             = azurerm_resource_group.resgroup.name
  location                        = azurerm_resource_group.resgroup.location
  size                            = var.containers[each.key].size
  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.nics[each.key].id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name    = "20.04.202111100"
    product = "null"
    publisher = "Canonical"
  }

  source_image_reference {
    offer = "0001-com-ubuntu-confidential-vm-focal"
    publisher = "Canonical"
    sku = "20_04-lts-cvm"
    #urn = "Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-cvm:20.04.202111100"
    version = "20.04.202111100"
  }

  #  plan {
  #    name      = "centos-8-stream-free"
  #    product   = "centos-8-stream-free"
  #    publisher = "cognosys"
  #  }
  #
  #  source_image_reference {
  #    publisher = "cognosys"
  #    offer     = "centos-8-stream-free"
  #    sku       = "centos-8-stream-free"
  #    version   = "1.2019.0810"
  #  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.staccount.primary_blob_endpoint
  }

  tags = {
    environment = "CP2"
  }

}