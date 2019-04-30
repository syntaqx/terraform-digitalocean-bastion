output "ipv4_address" {
  value = "${digitalocean_droplet.bastion.ipv4_address}"
}

output "ipv4_address_private" {
  value = "${digitalocean_droplet.bastion.ipv4_address_private}"
}

output "ipv6_address" {
  value = "${digitalocean_droplet.bastion.ipv6_address}"
}

output "floating_ip_address" {
  value = "${digitalocean_floating_ip.bastion.ip_address}"
}
