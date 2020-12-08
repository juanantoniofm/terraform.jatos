


/*
resource "digitalocean_vpc" "jatosvpc" {
  name     = "jatos-project-network"
  region   = "ams3"
  ip_range = "10.11.12.0/24"
}
*/

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

provider "random" {
  version = "3.0.0"
}