
# Terrafrom Code 

This folder contains the code to provision a basic infrastructure.

(If you are unfamiliar with Terraform, there is a very good hands on tutorial on their website.)


This code wil spin up a digital ocean droplet, and a database instance connected.
It will also provision a floating IP, so you can replace the instance without having
to reconfigure your DNS.

DNS has to be configured separately, or you can add it to this code later.
After 



# Code Structure

I'm going to highlight some of the more interesting files, in case you are not very 
familiar with terraform.

## terraform files

### backend.tf, database.tf, firewall.tf

Contains the code to create the digital ocean droplet.
Spins up a database, with MySQL, so you don't have to manage it yourself.
firewall also sets up some rules to ensure the DB is not reachable from the internet,
and that the droplet is not "just open".

### outputs.tf

Collects some relevant information after the provisioning process, and
provides that as output.

### providers.tf, variables.tf

internal terraform stuff, don't worry about it.

## Other files

### user-data.yaml.tmpl

Use this file to configure the instance on creation.
