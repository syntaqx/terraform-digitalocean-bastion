output "bastion_ip_address" {
  value = "${module.bastion.floating_ip_address}"
}
