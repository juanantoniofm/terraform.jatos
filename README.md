# Jatos on terraform

The plan is to create an instance, and deploy jatos,
for now with a simple docker-compose in a single instance.


# Plans

This repo will spin up one machine, and then
from it clone a repo with a basic docker compose config.

This will give us a working base for bulding a jatos setup with 2 servers, one for the java backend and another for the DB. 



# Resources required

- create a ssh key in .secrets/deploy
- create a digitalocean token and put it in tf.vars
- you will need another repo, to configcure the docker-compose stuff that you want to run on the server.

# Development

If you want to participate, open an issue on github.


## Status

- Spins up a droplet in digitalocean.
- git clone fails due to host verification
- we still need to install docker-compose