// create ssh keys for compute resources
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "pt_key.pem"
  file_permission = "0600"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2204-lts"
}

// create test VM
resource "yandex_compute_instance" "test_vm" {
  folder_id   = var.folder_id
  name        = "${var.project}-vm"
  hostname    = "${var.project}-vm"
  platform_id = "standard-v3"
  zone        = var.region

  #   service_account_id = yandex_iam_service_account.registry_sa.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_network.default.subnet_ids[2]
    nat       = false
  }

  metadata = {
    user-data = templatefile("./templates/cloud-init_test_vm.tpl.yaml",
      {
        ssh_key_pub = chomp(tls_private_key.ssh.public_key_openssh),
        username    = var.vm_user,
        vm_password = "$2y$05$bBDqeKltzU1YW1QEXngYGu/RAZpBZ33a2E6VUY2n2nsnBr9MObLkC",
    })
    serial-port-enable = "1"
  }
}

