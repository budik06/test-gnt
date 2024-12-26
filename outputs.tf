output "vpc_network_subnet_ids" {
  value = tolist(data.yandex_vpc_network.default.subnet_ids)
}

output "vpc_network_subnet_d" {
  value = data.yandex_vpc_network.default.subnet_ids[2]
}

output "vpc_network_subnet_d_cidr" {
  value = data.yandex_vpc_subnet.subnet-d.v4_cidr_blocks
}

output "ubuntu_image_id" {
  value = data.yandex_compute_image.ubuntu_image.image_id
}

output "path_for_private_ssh_key" {
  value = "./pt_key.pem"
}

output "vm_username" {
  value = var.vm_user
}

output "test_vm_password" {
  value     = random_password.test_vm_password.result
  sensitive = true
}
