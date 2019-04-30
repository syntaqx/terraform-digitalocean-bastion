# Terraform - Bastion (DigitalOcean)

[![CircleCI](https://circleci.com/gh/syntaqx/terraform-digitalocean-bastion.svg?style=shield)](https://circleci.com/gh/syntaqx/terraform-digitalocean-bastion)
![Latest GitHub Pre-Release](https://img.shields.io/github/tag-pre/syntaqx/terraform-digitalocean-bastion.svg?label=pre-release)

Terraform module for provisioning a Bastion Host on DigitalOcean

## Prerequisites

* DigitalOcean Account
* [Terraform](https://www.terraform.io/)

## Getting started

```hcl
resource "digitalocean_ssh_key" "bastion" {
  name       = "bastion"
  public_key = "${file("~/.ssh/bastion_rsa.pub")}"
}

module "bastion" {
  source = "syntaqx/bastion/digitalocean"
  prefix = "${format("example-%s", local.env)}"
  region = "nyc3"

  ssh_keys        = ["${digitalocean_ssh_key.bastion.id}"]
  ssh_private_key = "${file("~/.ssh/bastion_rsa")}"
}
```

## Security vulnerabilities

If you discover a security vulnerability within protokit, please send an e-mail
to Chase Pierce via syntaqx@gmail.com. All security vulnerabilities will be
promptly addressed.

## License

[MIT]: https://opensource.org/licenses/MIT

This project is open source software released under the [MIT license][MIT].
