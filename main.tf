provider "google" {
  project = "gcp-monolith-hunduri"
  region  = "us-central1"
}

resource "google_compute_instance" "monolith_server" {
  name         = "monolith-server"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Assigns a public IP
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y git curl unzip ufw
    sudo ufw allow OpenSSH
    sudo ufw allow http
    sudo ufw allow https
    sudo ufw enable
  EOT

  tags = ["http-server", "https-server"]
}
