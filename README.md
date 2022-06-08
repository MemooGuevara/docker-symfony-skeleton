# Docker skeleton for Symfony

This repository contains a Docker Compose structure to start your new Symfony ^5.x project. 

It has containers with:
- The latest NGINX container (you can change the version under `docker/nginx/Dockerfile`)
- The latest PHP-FPM container (you can change the version under `docker/php/Dockerfile`)
- The latest MySQL container (you can change the version under `docker/database/Dockerfile`)

Some useful tools like:
- Composer: to install dependencies in your Symfony project
- Symfony binary: to be able to do things like run a local web server to run your project
- PHP-CS-FIXER v3: to fix your coding style with a single command (see `Makefile` => `make code-style`)
- A basic XDEBUG 3 configuration (you can add or remove configuration under `docker/php/xdebug.ini`)


## Installation

- `make start` to spin up the application container
- `make ssh-app` to access the of the application container's bash

(check other targets in `Makefile`)

Now you can run `symfony` commands to create a new project and so on. (See https://symfony.com/download for more info)

Note: if you get a GIT error during the creation of a new project just set your GITHUB username and email with:
```
git config --global user.name "[your name]"
git config --global user.email "[your email]"
```
or just use the `--no-git` flag (e.g: `symfony new --dir=my-project --no-git`)


## Thanks

This repository is based on the [codenip-tech](https://github.com/codenip-tech) repository. (See [docker-skeleton-for-symfony](https://github.com/codenip-tech/docker-skeleton-for-symfony) for more info)


## License

MIT License