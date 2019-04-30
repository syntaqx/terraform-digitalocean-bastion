variable "prefix" {
}

variable "region" {
}

variable "image" {
  default = "ubuntu-18-04-x64"
}

variable "size" {
  default = "512mb"
}

variable "ssh_keys" {
  type = "list"
}

variable "tags" {
  type    = "list"
  default = []
}

variable "backups" {
  default = false
}

variable "monitoring" {
  default = true
}

variable "ssh_username" {
  default = "root"
}

variable "ssh_private_key" {
  default = ""
}

variable "allowed_source_addresses" {
  default = ["0.0.0.0/0", "::/0"]
}
