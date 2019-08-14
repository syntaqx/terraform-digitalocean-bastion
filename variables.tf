variable "prefix" {
  description = "The name prefix given to all created resources."
}

variable "region" {
  description = "The region to deploy resources to."
  default     = "nyc3"
}

variable "image" {
  description = "The DigitalOcean droplet image name or slug."
  default     = "ubuntu-18-04-x64"
}

variable "size" {
  description = "The DigitalOcean droplet size slug."
  default     = "s-1vcpu-1gb"
}

variable "ssh_keys" {
  description = "A list of SSH IDs or fingerprints to enable in the format [12345, 123456]."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A list of the tags to label this Droplet. A tag resource must exist before it can be associated."
  type        = list(string)
  default     = []
}

variable "backups" {
  description = "Whether to enable backups. Defaults to false."
  default     = false
}

variable "monitoring" {
  description = "Whether to enable the current monotiring agent. Defaults to true."
  default     = true
}

variable "ssh_agent" {
  description = "Whether to enable sharing the hosts ssh-agent. Defaults to true."
  default     = true
}

variable "ssh_username" {
  description = "User to use to login to the resource."
  default     = "root"
}

variable "ssh_private_key" {
  description = "The private SSH key. If this is a file, it can be read using the file interpolation function."
  default     = ""
}

variable "allowed_source_addresses" {
  description = "An array of strings containing the IPv4/6 addresses, and IPv4/6 CIDRs from which the inbound traffic will be accepted."
  default     = ["0.0.0.0/0", "::/0"]
}
