
resource "digitalocean_database_cluster" "mysql_jatos" {
  name       = "jatos-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
  maintenance_window {
    day  = 6
    hour = 01
  }
  tags = ["jatos-web"]
}

resource "digitalocean_database_db" "jatosdb" {
  cluster_id = digitalocean_database_cluster.mysql_jatos.id
  name       = "jatosdb"
}

resource "digitalocean_database_user" "jatos" {
  cluster_id = digitalocean_database_cluster.mysql_jatos.id
  name       = "jatos"
}

output "dbpassword" {
  value     = digitalocean_database_user.jatos.password
  sensitive = true
}

output "dbhost" {
  value = digitalocean_database_cluster.mysql_jatos.host
}


output "dbport" {
  value = digitalocean_database_cluster.mysql_jatos.port
}


output "private_uri" {
  value = digitalocean_database_cluster.mysql_jatos.private_uri
}

