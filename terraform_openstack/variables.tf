# Define variables
variable "auth_data" {
  type = object({
    application_credential_id     = string
    application_credential_secret = string
    auth_url                      = string
  })
  sensitive = true
}

variable "next_cloud_node" {
  type = object({
    name         = string
    flavor_name  = string
    floating_ip  = string
    image_id     = string
    key_pair     = string
    network_name = string
    volume_size  = number
  })
}

variable "db_node" {
  type = object({
    name         = string
    flavor_name  = string
    image_id     = string
    key_pair     = string
    volume_size  = number
    network_name = string
  })
}

variable "redis_node" {
  type = object({
    name         = string
    flavor_name  = string
    image_id     = string
    key_pair     = string
    volume_size  = number
    network_name = string
  })
}