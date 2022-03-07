variable "location" {
  type = string
  description = "Region to deploy infrastructure"
  default = "eastus"
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "<STORAGE ACCOUNT NAME>"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "<SSH USER>"
}

variable "vnet_slash_16" {
  type = string
  description = "Network prefix for vnet"
  default = "10.10"
}

variable "vsubnet_slash_24" {
  type = string
  description = "Network prefix for vnet"
  default = "10.10.10"
}

variable "containers" {
  type = map(object({
    id = number #This also is the 4th IP factor (don't expect more than 10 machines, and max is 255-2<broadcast&network)=253 available ips)
    desc = string
  }))
  description = "Container info"
  default = {
    "ansible-controller" = {
      id="10",
      desc="Container to perform deployments on rest of containers"
    },
    "kubernetes-master" = {
      id="20",
      desc="NFS server"
    },
    "kubernetes-worker1" = {
      id="30",
      desc="Kubernetes worker 1"
    },
    "nfs" = {
      id="40",
      desc="NFS server"
    }
  }
}
