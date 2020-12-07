variable "api_token" {}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.3.0"
    }
  }
}

provider "digitalocean" {
  token = var.api_token
}

provider "local" {
  version = "2.0.0"
}

resource "digitalocean_droplet" "web" {
  image              = "ubuntu-20-04-x64"
  name               = "jatos-web"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  monitoring         = true
  ipv6               = true
  private_networking = true
  user_data          = file("user-data.yaml")
}

resource "local_file" "sshconf" {
  content  = <<-EOT
        Host jatos-root
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22
            User root
            EscapeChar none
        
        Host jatos-web
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22022
            User admin
            IdentityFile ../.secrets/admin
            EscapeChar none
        EOT
  filename = "${path.module}/ssh_config.tf"
}

output "public_ip" {
  value = digitalocean_droplet.web.ipv4_address
}