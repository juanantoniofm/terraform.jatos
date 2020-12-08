variable "api_token" {}


resource "digitalocean_droplet" "web" {
  image              = "ubuntu-20-04-x64"
  name               = "jatos-web"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  monitoring         = true
  ipv6               = true
  private_networking = true
  user_data          = file("user-data.yaml")
  //vpc_uuid           = digitalocean_vpc.jatosvpc.id
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