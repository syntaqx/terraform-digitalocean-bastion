provider "digitalocean" {}

locals {
  env = "${terraform.workspace == "default" ? "dev" : terraform.workspace}"
}

resource "digitalocean_tag" "bastion" {
  name = "bastion"
}

resource "digitalocean_ssh_key" "bastion" {
  name       = "bastion"
  public_key = "${tls_private_key.bastion.public_key_openssh}"
}

module "bastion" {
  source = "../"
  prefix = "${format("example-%s", local.env)}"
  region = "nyc3"
  tags   = ["${digitalocean_tag.bastion.id}"]

  ssh_keys        = ["${digitalocean_ssh_key.bastion.id}"]
  ssh_private_key = "${tls_private_key.bastion.private_key_pem}"
}
