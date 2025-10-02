provider "google" {
  project     = "personal-portfolio-473906"
  region      = "us-west1"
  credentials = file("C:/Terraform/personal-portfolio-473906-62fae1b910b8.json")
}

# Reserve a static IP
resource "google_compute_address" "portfolio_ip" {
  name   = "portfolio-static-ip"
  region = "us-west1"
}

# Allow HTTP & HTTPS
resource "google_compute_firewall" "allow-http-https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server", "https-server"]
}

# Create VM
resource "google_compute_instance" "portfolio-vm" {
  name         = "portfolio-vm"
  machine_type = "e2-micro"
  zone         = "us-west1-a"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 10
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Attach the static external IP
      nat_ip = google_compute_address.portfolio_ip.address
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install -y nginx git
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOT
}
