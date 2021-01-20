# Jatos on terraform

The plan is to create an instance, and deploy jatos,
for now with a simple docker-compose in a single instance.

## Plans

This repo will spin up one machine, and then
from it clone a repo with a basic docker compose config.

This will give us a working base for bulding a jatos setup with 2 servers, one for the java backend and another for the DB. 

## Usage

To start using this repo, after cloning it, you'll need to install some tols, and create a few secrets.

### Dependencies

This repo uses [TF Env](https://github.com/tfutils/tfenv) to manage terraform versions.
This means you need terraform as well, and you can use your own setup, but we recommend tfenv to manage it for you.




### Previous steps required

- You will need to create 2 ssh keys, one to manage your system, and another one to deploy,  in .secrets/ folder.

    run this command to create a new key. You will be able to specify the path and the password as you go along.

        ssh-keygen 

- create a digitalocean token and put it in `tf.vars`. I use `backend.auto.tfvars` for it, see example below.

    Go to digitalocean.com and open and accont. Go to settings, API and generate a new token.

    Get the string of the token, and put it in a file, like this:

            api_token = "d4t1515n071r34l70k3nbruvd773aa120k010kj01040k007eb413523b"
        

- At this point, to configure the application, you will need another repo, [docker.jatos](github.com/juanantoniofm/docker.jatos), to hold the configuration of the services you want to spin up.

## Support

If you have trouble using this, open an issue on Github.

## Development

If you want to participate, open an issue on Github.

I keep a [Development](docs/Development.md) document with some notes on the status and steps that I take.
