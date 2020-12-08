variable "api_token" {}


resource "digitalocean_droplet" "web" {
  image              = "ubuntu-20-04-x64"
  name               = "jatos-web"
  region             = "ams3"
  size               = "s-1vcpu-1gb"
  monitoring         = true
  ipv6               = true
  private_networking = true
  tags               = ["jatos-web"]
  user_data = templatefile("user-data.yaml.tmpl", {
    dbpassword         = digitalocean_database_user.jatos.password
    dbhost             = digitalocean_database_cluster.mysql_jatos.host
    dbport             = digitalocean_database_cluster.mysql_jatos.port
    dbname             = digitalocean_database_db.jatosdb.name
    ssh_jatos_password = random_password.ssh_jatos_password.result
  })
}


resource "random_password" "ssh_jatos_password" {
  length           = 16
  special          = true
  override_special = "_%@!;"
}

output "ssh_jatos_password" {
  value = random_password.ssh_jatos_password.result
}


resource "local_file" "sshconf" {
  content  = <<-EOT
        Host jatos-rescue
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22
            User root
            EscapeChar none
        
        Host jatos-root
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22022
            User root
            EscapeChar none

        Host jatos-web
            HostName ${digitalocean_droplet.web.ipv4_address}
            Port 22022
            User jatos
            IdentityFile ../.secrets/admin
            EscapeChar none
        EOT
  filename = "${path.module}/ssh_config.tmp"
}

output "public_ip" {
  value = digitalocean_droplet.web.ipv4_address
}
