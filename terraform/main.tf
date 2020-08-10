terraform {  
  # Версия terraform  
  required_version = "0.11.14"
}

provider "google" {  
  # Версия провайдера  
  version = "2.20"  
  # ID проекта  
  project = "${var.project}"
  region = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         	= "reddit-app"
  machine_type 	= "g1-small"
  zone         	= "${var.zone}"
  tags		= ["reddit-app"]
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
  metadata {
    # путьдопубличногоключа
    ssh-keys = "vvp030303:${file(var.public_key_path)}"
  }
  connection {
    type          = "ssh"
    user          = "vvp030303"
    agent         = false
    # путьдоприватногоключа
    private_key   = "${file(var.private_key_path)}"
  }
  provisioner "file" {
    source        = "files/puma.service"
    destination   = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall""firewall_puma" {
  name = "allow-puma-default"
  # Названиесети, вкоторойдействуетправило
  network = "default"
  # Какойдоступразрешить
  allow {  
    protocol = "tcp"    
	ports = ["9292"]  
	}  
  # Какимадресамразрешаемдоступ  
  source_ranges = ["0.0.0.0/0"]  
  # Правилоприменимодляинстансовсперечисленнымитэгами  
  target_tags = ["reddit-app"]
}
