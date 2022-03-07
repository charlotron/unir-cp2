variable "location" {
  type = string
  description = "Region to deploy infrastructure"
  default = "eastus"
}

variable "storage_account" {
  type = string
  description = "Storage account name"
  default = "cp2sg"
}

variable "public_key_path" {
  type = string
  description = "Public ssh key location on local machine"
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  type = string
  description = "ssh user"
  default = "cp2admin"
}

variable "subscription_data_subscription_id" {
  type = string
  description = "subscription_id from subscription"
}

variable "subscription_data_client_id" {
  type = string
  description = "client_id from subscription"
}

variable "subscription_data_client_secret" {
  type = string
  description = "client_secret from subscription"
}

variable "subscription_data_tenant_id" {
  type = string
  description = "tenant_id from subscription"
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
    size = string
  }))
  description = "Container info"
  default = {
    "ansible-controller" = {
      id="10",
      desc="Container to perform deployments on rest of containers",
      size="Standard_B1ls"
    },
    "kubernetes-master" = {
      id="20",
      desc="NFS server",
      size="Standard_B1ms"
    },
    "kubernetes-worker1" = {
      id="30",
      desc="Kubernetes worker 1",
      size="Standard_B1s"
    },
    "nfs" = {
      id="40",
      desc="NFS server",
      size="Standard_B1ls"
    }
  }
}
