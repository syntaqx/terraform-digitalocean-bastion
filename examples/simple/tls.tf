# @NOTE: This is considered extremely poor security as the generated key will
# be stored unencrypted in the terraform state. This is just for the example.
resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_key" {
  filename = ".ssh/bastion_rsa"
  content  = tls_private_key.bastion.private_key_pem
}

resource "local_file" "ssh_key_public" {
  filename = ".ssh/bastion_rsa.pub"
  content  = tls_private_key.bastion.public_key_openssh
}

