
resource "digitalocean_database_cluster" "mysql-jatos" {
  name       = "jatos-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
  //private_network_uuid = digitalocean_vpc.jatosvpc.id
}

resource "random_password" "dbpassword" {
  length           = 16
  special          = true
  override_special = "_%@!;"
}

output "dbpassword" {
  value = random_password.dbpassword.result
}

