
resource "digitalocean_firewall" "web" {
  name = "only-ssh-and-web"

  droplet_ids = [digitalocean_droplet.web.id]
  tags        = ["jatos-web"]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22022"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65500"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Development ports. Only enable while working on infrastructure changes.
  // JATOS Backend port
  inbound_rule {
    protocol         = "tcp"
    port_range       = "9000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Trafiek UI
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

}



resource "digitalocean_database_firewall" "mysql_jatos_fw" {
  cluster_id = digitalocean_database_cluster.mysql_jatos.id

  rule {
    type  = "ip_addr"
    value = "10.110.0.0/24"
  }

  rule {
    type  = "droplet"
    value = digitalocean_droplet.web.id
  }

  rule {
    type  = "tag"
    value = "jatos-web"
  }

}
