



terraform {
  required_version = "= 0.13"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.3.0"
    }
  }
}


provider "digitalocean" {
  token = var.api_token
}
