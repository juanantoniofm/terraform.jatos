# Jatos on terraform

The plan is to create an instance, and deploy jatos,
for now with a simple docker-compose in a single instance.

## Plans

This repo will spin up one machine, and then
from it clone a repo with a basic docker compose config.

This will give us a working base for bulding a jatos setup with 2 servers, one for the java backend and another for the DB. 

## Usage

To start using this repo, after cloning it, you'll need to install some tools. Take a look at "dependencies" below.

After you clone the repo, You can use `make install` 

### Dependencies

Having "make" on your machine, will definetely make your life easier. If you can't use `make`, take a look at the makefile anyway to get an idea of how things work and what are you supposed to run on each step.

This repo uses [TF Env](https://github.com/tfutils/tfenv) to manage terraform versions.
You can install Terraform on your own as well, but we recommend tfenv to manage it for you.

### MacOS

Run something like this to get started

    brew install tfenv make
    make install

### Linux

If you are using debian or ubuntu, you could do

    TODO: Write steps for linux/ubuntu setup of tfenv. make should be in the distro already.
    make install

### Windows

With windows, it becomes a bit trickier. I can't provide a "blanket" solution, as there are many options like 

- Use linux natively using WSL (watch out for performance issues on NTFS filesystems)

- Use a distro like MinGW, CygWin, Mobaxterm, etc.

- Use native windows tools, like `cmder` and `chocolatey`. You might have to check the Makefile as some commands will differ.

### Other Optional Previous steps required

Most of this things should be solved by running `make install`, but these are some steps to recreate it in case make failed for you.

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
