data "template_file" "cloud_config" {
  template = file("${path.module}/templates/cloud-config.tpl")
}

resource "digitalocean_floating_ip" "bastion" {
  region = var.region
}

resource "digitalocean_droplet" "bastion" {
  name     = format("%s-bastion-%s", var.prefix, var.region)
  region   = var.region
  image    = var.image
  size     = var.size
  tags     = var.tags
  ssh_keys = var.ssh_keys

  private_networking = true
  ipv6               = true
  monitoring         = var.monitoring
  backups            = var.backups

  user_data = data.template_file.cloud_config.rendered

  connection {
    host        = self.ipv4_address
    type        = "ssh"
    agent       = var.ssh_agent
    user        = var.ssh_username
    private_key = var.ssh_private_key
    timeout     = "2m"
  }

  # Block until cloud-init has finished so module usecases don't have to.
  # https://github.com/terraform-providers/terraform-provider-digitalocean/issues/280
  provisioner "remote-exec" {
    script = "${path.module}/scripts/wait_for_cloud_init.sh"
  }
}

resource "digitalocean_floating_ip_assignment" "bastion" {
  ip_address = digitalocean_floating_ip.bastion.id
  droplet_id = digitalocean_droplet.bastion.id
}

resource "digitalocean_firewall" "bastion" {
  name        = format("%s-bastion-fw", var.prefix)
  droplet_ids = [digitalocean_droplet.bastion.id]

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Bastions are for SSH so this should be the only port needed?
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.allowed_source_addresses
  }
}

