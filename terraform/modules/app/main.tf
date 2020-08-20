resource "google_compute_instance""app" {
  name = "reddit-app"
  machine_type = "g1-small"
  zone = "${var.zone}"
  tags = ["reddit-app"]
  boot_disk {
    initialize_params { 
     image = "${var.app_disk_image}"
    }
  }
  network_interface {
    network = "default"
    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
  metadata {
    ssh-keys = "vvp:${file(var.public_key_path)}"
  }
  connection {
    type          = "ssh"
    user          = "vvp030303"
    agent         = false
    # путьдоприватногоключа
#    private_key   = "${file(var.private_key_path)}"
     private_key   = "${file("~/.ssh/id_rsa")}"
  }
  provisioner "file" {
    source        = "../files/puma.service"
    destination   = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "../files/deploy.sh"
  }
}

resource "google_compute_address" "app_ip" { name = "reddit-app-ip" }

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp", ports = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["reddit-app"]
}

