
# Development

If you want to contribute, feel free to fork and open a PR, or open an issue on github with your feature, bug, or question.

## Status

### Done

- [x] Spins up a droplet in digitalocean.
- [x] added a db cluster with mysql 8 to it.
- [x] Injecting secrets via cloudinit templatefile.
- [x] And we need to configure the ip of the db on the instance
- [x] Add "Trusted sources" to the db
- [x] git clone host verification
- [x] install docker-compose
- [x] Add other db and trafiek config vars to the env file

### To Do

- [ ]  Unlock the bloody jatos user account
  - I tried with the usermod command, but it does'nt work on cloud-init.
  - when i run it manually as root, it does work... ffs
  - I'm trying to debug with a custom stdout/err redirection on the command.
- [ ] git clone deploy SSH key
- [ ]  If the ssh key injection works, inject an env file as well.
    maybe nest the data structure in something nicer.

- [ ] Create database with the right encoding CREATE DATABASE jatos CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
