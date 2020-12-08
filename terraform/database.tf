
resource "digitalocean_database_cluster" "mysql-jatos" {
  name       = "jatos-mysql-cluster"
  engine     = "mysql"
  version    = "8"
  size       = "db-s-1vcpu-2gb"
  region     = "ams3"
  node_count = 1
  //private_network_uuid = digitalocean_vpc.jatosvpc.id
}
