node
====

This docker image is for locale development and **NOT FOR PRODUCTION** usage.

You have been warned, because the priorities are different i will use comfort over security, size or best practices for
production.

For example:

* I added sudo without a password to the container
* I added the user to the `sudo` group
* I added `vim` (because i like it)
* I didn't remove the apt/list.d directory

Those are all the small things that make my life easier as a developer, but scares me as an admin.

## Quick start

On the first run you need to execute

```bash
make install
```

After all config is initialized you can start all docker container.

```bash
make start
```

Open [http://localhost:8000]

This will start all docker container defined in the ```docker-compose.yaml``` files in the
module directories.


## Dependencies

The ```docker``` and ```core``` modules are required for this to work properly.


## Concept
The main idea of those docker container is to open the bash inside the container and do the default work
inside this container.

Organizing and doing install/create or build docker images, I will create make targets for, so using
them in a ci/cd environment should require you only calling them with the possibility to fine tune steps, without
the need for operations to take action.


### So please don't use this image for production.
