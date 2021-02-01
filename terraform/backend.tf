


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
    ssh_jatos_pkey     = filebase64("../.secrets/deploy")
    ssh_admin_public   = file("../.secrets/admin.pub") # TODO: try to load the key dinamically
  })
  ssh_keys = [digitalocean_ssh_key.jatos_key.id] // Root user allowed SSH Key. Prevents the root password email.
}


// Because we want a floating IP that persists between refreshes
resource "digitalocean_floating_ip" "external_ip" {
  droplet_id = digitalocean_droplet.web.id
  region     = digitalocean_droplet.web.region
}


// Security and SSH
resource "digitalocean_ssh_key" "jatos_key" {
  name       = "Jatos admin user key"
  public_key = file("../.secrets/admin.pub")
}

resource "random_password" "ssh_jatos_password" {
  length           = 16
  special          = true
  override_special = "_%@!;"
}


resource "local_file" "sshconf" {
  content  = <<-EOT
        Host jatos-rescue
            HostName ${digitalocean_floating_ip.external_ip.ip_address}
            Port 22
            User root
            EscapeChar none
        
        Host jatos-root
            HostName ${digitalocean_floating_ip.external_ip.ip_address}
            Port 22022
            User root
            IdentityFile ../.secrets/admin
            EscapeChar none

        Host jatos-web
            HostName ${digitalocean_floating_ip.external_ip.ip_address}
            Port 22022
            User jatos
            IdentityFile ../.secrets/admin
            EscapeChar none
        EOT
  filename = "${path.module}/ssh_config.tmp"
}