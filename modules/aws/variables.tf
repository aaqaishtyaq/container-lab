variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "container_lab"
}

variable "deployer_pub_key" {
  description = "Public ssh key of the deployer, to be used for SSH"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYZjYRGgzYBn6PhTnn4LmQ/AsF5E7RVe10zYYsVQz/w aaqaishtyaq@gmail.com"
}

variable "root_volume_size" {
  type    = string
  default = "30"
}
