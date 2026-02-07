terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.yc_service_account_key_file
  cloud_id = var.cloud_id
  folder_id = var.folder_id  # Уже существующий каталог
  zone     = var.zone
}


data "yandex_compute_image" "ubuntu_24_04" {
  family = "ubuntu-2404-lts"  # Имя семейства образов (стандартное для Ubuntu 24.04)
}

// 1. Сеть (в существующем каталоге)
resource "yandex_vpc_network" "default" {
  name     = "password-manager-network"
  folder_id = var.folder_id
}

// 2. Подсеть (в существующем каталоге)
resource "yandex_vpc_subnet" "default" {
  name           = "password-manager-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.128.0.0/24"]
  folder_id      = var.folder_id
}

// 3. Виртуальная машина (в существующем каталоге)
resource "yandex_compute_instance" "password_manager_server" {
  name     = "password-manager-server"
  folder_id = var.folder_id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      size     = 20
      image_id = data.yandex_compute_image.ubuntu_24_04.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/Users/ramires/.ssh/id_rsa.pub")}"
  }

  service_account_id = var.service_account_id
}

// Выводы
output "external_ip" {
  value       = yandex_compute_instance.password_manager_server.network_interface[0].nat_ip_address
  description = "Внешний IP-адрес сервера"
}

output "folder_id" {
  value       = var.folder_id
  description = "ID используемого каталога"
}
