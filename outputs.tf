output "droplet" {
  value = digitalocean_droplet.bastion
}

output "floating_ip" {
  value = digitalocean_floating_ip.bastion
}
