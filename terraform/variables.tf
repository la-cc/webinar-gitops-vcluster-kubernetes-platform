### Project related variabls
variable "project_region" {
  type        = string
  description = "Region of the project."
  default     = "eu01"
}

variable "project_id" {
  type        = string
  description = "The StackIT ProjectID."
}

variable "stage" {
  type        = string
  description = "Project stage for resource naming and tagging."
}


### STACKIT Provider related variables
variable "service_account_key_path" {
  type        = string
  description = "Path to the service account key (json) to connect to StackIT project."
}

variable "private_key_path" {
  type        = string
  description = "Path to the service account private key (pem)."
}



### Bucket related variables
variable "bucket_name" {
  type        = string
  description = "Bucket name."
}

variable "tf_state_bucket_key" {
  type        = string
  default     = "terraform-state"
  description = "The bucket key-name for your backend configuration. Changes only output."
}


variable "obs_credentials_group_id" {
  type        = string
  description = "ObjectStorage Credentials Group ID for creating an OBS Credential."
}


### Kubernetes/SKE Cluster related variables
variable "kubernetes_version_min" {
  type        = string
  description = "The minimum version of Kubernetes to use."
  default     = "1.31.4"

}

variable "node_pools" {

  description = "values for node pools"
  type = list(object({
    availability_zones = list(string)
    machine_type       = string
    maximum            = number
    minimum            = number
    name               = string
    os_version_min     = string

    labels = map(string)

    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))

  default = []
}



### General variables
variable "tags" {
  type    = map(string)
  default = {}
}