provider "digitalocean" {
}

data "template_file" "cloud_config" {
  template = "${file("${path.module}/templates/cloud-config.tpl")}"
}

resource "digitalocean_floating_ip" "bastion" {
  region = "${var.region}"
}

resource "digitalocean_droplet" "bastion" {
  name     = "${format("%s-bastion-%s", var.prefix, var.region)}"
  region   = "${var.region}"
  image    = "${var.image}"
  size     = "${var.size}"
  ssh_keys = ["${var.ssh_keys}"]
  tags     = ["${var.tags}"]

  private_networking = true
  ipv6               = true
  monitoring         = false
  backups            = "${var.backups}"

  user_data = "${data.template_file.cloud_config.rendered}"

  connection {
    type        = "ssh"
    agent       = false
    user        = "${var.ssh_username}"
    private_key = "${var.ssh_private_key}"
    timeout     = "2m"
  }

  # Outputs cloud-init and lets the boot finish before Terraform considers the
  # resource creation to be completed.
  provisioner "remote-exec" {
    inline = [
      "tail -f /var/log/cloud-init-output.log &",
      "until [ -f /var/lib/cloud/instance/boot-finished ]; do sleep 1; done",
    ]
  }

  # https://www.digitalocean.com/docs/monitoring/how-to/upgrade-legacy-agent/
  provisioner "remote-exec" {
    inline = [
      "apt-get -y purge do-agent",
      "${var.monitoring} && then curl -sSL https://insights.nyc3.cdn.digitaloceanspaces.com/install.sh | sudo bash",
    ]
  }
}

resource "digitalocean_floating_ip_assignment" "bastion" {
  ip_address = "${digitalocean_floating_ip.bastion.id}"
  droplet_id = "${digitalocean_droplet.bastion.id}"
}

resource "digitalocean_firewall" "bastion" {
  name        = "${format("%s-bastion-inbound-ssh-fw", var.prefix)}"
  droplet_ids = ["${digitalocean_droplet.bastion.id}"]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["${var.allowed_source_addresses}"]
  }
}
