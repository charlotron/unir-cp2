variable "subscription_data_subscription_id" {
  type        = string
  description = "subscription_id from subscription"
}

variable "subscription_data_client_id" {
  type        = string
  description = "client_id from subscription"
}

variable "subscription_data_client_secret" {
  type        = string
  description = "client_secret from subscription"
}

variable "subscription_data_tenant_id" {
  type        = string
  description = "tenant_id from subscription"
}

variable "vnet_slash_16" {
  type        = string
  description = "Network prefix for vnet"
  default     = "10.10"
}

variable "vsubnet_slash_24" {
  type        = string
  description = "Network prefix for vnet"
  default     = "10.10.10"
}

variable "containers" {
  type = map(object({
    id              = number,
    #This also is the 4th IP factor (don't expect more than 10 machines, and max is 255-2<broadcast&network)=253 available ips)
    size            = string,
    ansiblehostname = string,
    ansiblegroup    = string
  }))
  description = "Container info"
  default     = {
    "ansiblecontroller" = {
      id              = "10",
      size            = "Standard_B1s", #1vcpu 1gb ram 4b hd
      ansiblehostname = "ansiblecontroller.local",
      ansiblegroup    = ""
    },
    "kubernetesmaster" = {
      id              = "20",
      size            = "Standard_D2as_v4", #2vcpus 8gb ram 16gb hd
      ansiblehostname = "master.local",
      ansiblegroup    = "master"
    },
    "kubernetesworker1" = {
      id              = "30",
      size            = "Standard_B1s", #2vcpus 8gb ram 16gb hd
      ansiblehostname = "worker1.local",
      ansiblegroup    = "workers"
    },
#   We have a limit of 6 cores by region due to student account so i cannot wake up another worker node
    "kubernetesworker2" = {
      id              = "31",
      size            = "Standard_B1s", #2vcpus 8gb ram 16gb hd
      ansiblehostname = "worker2.local",
      ansiblegroup    = "workers"
    },
    "nfs" = {
      id                = "40",
      size              = "Standard_B1s", #1vcpu 1gb ram 4b hd
      ansiblehostname   = "nfs.local",
      ansiblegroup      = "nfs"
    }
  }
}
