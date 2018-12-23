locals {
  this_public_ip                    = "${compact(concat(coalescelist(aws_instance.this.*.public_ip, aws_instance.this_t2.*.public_ip), list("")))}"
  this_private_ip                   = "${compact(concat(coalescelist(aws_instance.this.*.private_ip, aws_instance.this_t2.*.private_ip), list("")))}"
}

output "public_ips" {
  description = "Public ips of instances"
  value       = ["${local.this_public_ip}"]
}

output "private_ips" {
  description = "Private ips of instances"
  value       = ["${local.this_private_ip}"]
}

