
resource "azurerm_linux_virtual_machine" "vms" {
  for_each = var.containers

  name                            = "cp2vm${each.key}"
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

  source_image_reference {
    offer     = "0001-com-ubuntu-confidential-vm-focal"
    publisher = "Canonical"
    sku       = "20_04-lts-gen2"
    #urn = "Canonical:0001-com-ubuntu-confidential-vm-focal:20_04-lts-gen2:20.04.202107090"
    version   = "20.04.202107090"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.staccount.primary_blob_endpoint
  }

#  #Set public/private keys to interconnect instances
#  provisioner "remote-exec" {
#    inline = [
#      "mkdir -p /home/${var.ssh_user}/.ssh",
#      #--- ONLY ANSIBLE CONTROLLER:
#      #Create private key "id_rsa"
#      "${each.value.ansiblecontroller} && echo \"${tls_private_key.ansiblecontrollerkey.private_key_pem}\" > /home/${var.ssh_user}/.ssh/id_rsa",
#      #Create public key "id_rsa.pub"
#      "${each.value.ansiblecontroller} && echo \"${substr(tls_private_key.ansiblecontrollerkey.public_key_openssh, 0, length(tls_private_key.ansiblecontrollerkey.public_key_openssh)-1)} ansiblecontroller\" > /home/${var.ssh_user}/.ssh/id_rsa.pub",
#      #Install "ansible" binaries in ansible controller
#      "${each.value.ansiblecontroller} && sudo apt-get update && sudo apt-get install -y ansible",
#
#      #--- ONLY ANSIBLE SLAVES:
#      #Avoid duplicated entries for ansible controller in "authorized_keys"
#      "! ${each.value.ansiblecontroller} && sed -i '/ansiblecontroller/d' /home/${var.ssh_user}/.ssh/authorized_keys",
#      #Add ansible controller public key to authorized_keys
#      "! ${each.value.ansiblecontroller} && echo \"${substr(tls_private_key.ansiblecontrollerkey.public_key_openssh, 0, length(tls_private_key.ansiblecontrollerkey.public_key_openssh)-1)} ansiblecontroller\" >> /home/${var.ssh_user}/.ssh/authorized_keys",
#
#      #Ensure proper rights for files if needed
#      "chmod 600 /home/${var.ssh_user}/.ssh/id_rsa || true",
#      "chmod 644 /home/${var.ssh_user}/.ssh/id_rsa.pub || true",
#      "chmod 700 /home/${var.ssh_user}/.ssh "
#    ]
#
#    connection {
#      host        = self.public_ip_address
#      type        = "ssh"
#      user        = var.ssh_user
#      private_key = file("~/.ssh/id_rsa")
#      agent       = "false"
#    }
#  }

  tags = {
    environment = "CP2"
  }
}

#Create a private/public key for ansible controller
resource "tls_private_key" "ansiblecontrollerkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#--- ONLY ANSIBLE CONTROLLER:
resource "null_resource" ansiblecontrollercfg {
  for_each = {for key, val in var.containers :key => val if key=="ansiblecontroller"}

  provisioner "remote-exec" {
    inline = [
      #Create private key "id_rsa"
      "echo \"${tls_private_key.ansiblecontrollerkey.private_key_pem}\" > /home/${var.ssh_user}/.ssh/id_rsa",
      #Create public key "id_rsa.pub"
      "echo \"${substr(tls_private_key.ansiblecontrollerkey.public_key_openssh, 0, length(tls_private_key.ansiblecontrollerkey.public_key_openssh)-1)} ansiblecontroller\" > /home/${var.ssh_user}/.ssh/id_rsa.pub",
      #Ensure proper rights for files if needed
      "chmod 600 /home/${var.ssh_user}/.ssh/id_rsa || true",
      "chmod 644 /home/${var.ssh_user}/.ssh/id_rsa.pub || true",
      "chmod 700 /home/${var.ssh_user}/.ssh ",
      #Install "ansible" binaries in ansible controller
      "sudo apt-get update && sudo apt-get install software-properties-common -y",
      "sudo apt-add-repository --yes ppa:ansible/ansible",
      "sudo apt-get update && sudo apt-get install ansible -y"
    ]

    connection {
      host        = azurerm_linux_virtual_machine.vms[each.key].public_ip_address
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("~/.ssh/id_rsa")
      agent       = "false"
    }
  }
}

#--- ONLY ANSIBLE SLAVES:
resource "null_resource" ansibleslavescfg {
  #Do only for ansible slaves
  for_each = {for key, val in var.containers :key => val if key!="ansiblecontroller"}

  provisioner "remote-exec" {
    inline = [

      #Avoid duplicated entries for ansible controller in "authorized_keys"
      "sed -i '/ansiblecontroller/d' /home/${var.ssh_user}/.ssh/authorized_keys",
      #Add ansible controller public key to authorized_keys
      "echo \"${substr(tls_private_key.ansiblecontrollerkey.public_key_openssh, 0, length(tls_private_key.ansiblecontrollerkey.public_key_openssh)-1)} ansiblecontroller\" >> /home/${var.ssh_user}/.ssh/authorized_keys",
      #Ensure proper rights for files if needed
      "chmod 600 /home/${var.ssh_user}/.ssh/id_rsa || true",
      "chmod 644 /home/${var.ssh_user}/.ssh/id_rsa.pub || true",
      "chmod 700 /home/${var.ssh_user}/.ssh "
    ]

    connection {
      host        = azurerm_linux_virtual_machine.vms[each.key].public_ip_address
      type        = "ssh"
      user        = var.ssh_user
      private_key = file("~/.ssh/id_rsa")
      agent       = "false"
    }
  }
}

output "public_ip_address" {
  value = zipmap( values(var.containers)[*].ansiblehostname, values(azurerm_linux_virtual_machine.vms)[*].public_ip_address )
}
