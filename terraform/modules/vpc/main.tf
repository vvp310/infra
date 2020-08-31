resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  network = "default"
  allow {
   protocol = "tcp"
    ports = ["22"]
  }
  source_ranges = "${var.source_ranges}"
}
resource "google_compute_firewall" "firewall_http_puma" {
  name = "http-puma"
  network = "default"
  allow {
   protocol = "tcp"
    ports = ["80"]
  }
  source_ranges = "${var.source_ranges}"
  target_tags = ["reddit-app"]
}
