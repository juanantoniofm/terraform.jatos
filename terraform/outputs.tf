
output "dbpassword" {
  value     = digitalocean_database_user.jatos.password
  sensitive = true
}

output "dbhost" {
  description = "Public URI of db instance"
  value       = digitalocean_database_cluster.mysql_jatos.host
}


output "dbport" {
  description = "DB Port"
  value       = digitalocean_database_cluster.mysql_jatos.port
}


output "private_uri" {
  description = "Private URI of the database cluster"
  value       = digitalocean_database_cluster.mysql_jatos.private_uri
}


output "web_ip" {
  value = digitalocean_floating_ip.external_ip.ip_address
}


output "ssh_jatos_password" {
  description = "SSH Password for the Jatos droplet."
  value       = random_password.ssh_jatos_password.result
  sensitive   = true
}