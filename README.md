# Terraform - Bastion (DigitalOcean)

[![CircleCI](https://circleci.com/gh/syntaqx/terraform-digitalocean-docker-swarm.svg?style=shield)](https://circleci.com/gh/syntaqx/terraform-digitalocean-docker-swarm)
![Latest GitHub Pre-Release](https://img.shields.io/github/tag-pre/syntaqx/terraform-digitalocean-docker-swarm.svg?label=pre-release)

Terraform module for provisioning Bastion Hosts on DigitalOcean

## Prerequisites

* DigitalOcean Account
* [Terraform](https://www.terraform.io/)

## Getting started

```hcl
module "bastion" {
  source = "syntaqx/bastion/digitalocean"
  # @TODO: add example usage when API is stable
}
```

## Security vulnerabilities

If you discover a security vulnerability within protokit, please send an e-mail
to Chase Pierce via syntaqx@gmail.com. All security vulnerabilities will be
promptly addressed.

## License

[MIT]: https://opensource.org/licenses/MIT

This project is open source software released under the [MIT license][MIT].
