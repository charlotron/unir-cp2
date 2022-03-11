resource "local_file" "ssh_script_env_files" {
  content = templatefile("../ssh_scripts/.env.tftpl",
    {
      ips = zipmap( keys(var.containers), values(azurerm_linux_virtual_machine.vms)[*].public_ip_address ),
    }
  )
  filename = "../ssh_scripts/.env"

  depends_on = [
    azurerm_linux_virtual_machine.vms,
    var.containers
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("../ansible/hosts.tftpl",
    {
      ssh_user = var.ssh_user,
      ips = zipmap( values(var.containers)[*].ansiblehostname, values(azurerm_linux_virtual_machine.vms)[*].public_ip_address ),
      localips = zipmap( values(var.containers)[*].ansiblehostname, values(azurerm_linux_virtual_machine.vms)[*].private_ip_address ),
      hostnameGroups=zipmap(values(var.containers)[*].ansiblehostname,values(var.containers)[*].ansiblegroup), #transpose function did not work so i have to do it in two steps
      groups=distinct(values(var.containers)[*].ansiblegroup)
    }
  )
  filename = "../ansible/hosts"

  depends_on = [
    azurerm_linux_virtual_machine.vms,
    var.containers
  ]
}