locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project
    test_cidr   = data.yandex_vpc_subnet.subnet-d.v4_cidr_blocks
  }
}

terraform {
  backend "local" {}
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.15"
}

provider "yandex" {
  profile = var.environment
  zone    = var.region
}

data "yandex_vpc_network" "default" {
  network_id = var.network_id
  folder_id  = var.folder_id
}

data "yandex_vpc_subnet" "subnet-d" {
  subnet_id = data.yandex_vpc_network.default.subnet_ids[2]
}
