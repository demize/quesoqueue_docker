# Queso Queue Docker

This repository is a Dockerfile, supporting files, and an example `queso.env`
and `docker-compose.yml` for Shoujo's [Queso Queue Plus][qqpgithub] project.

[qqpgithub]: https://github.com/ToransuShoujo/quesoqueue_plus

# Using the container

## Quick Start with Docker Compose

1. Install the [Docker Engine](https://docs.docker.com/engine/install/). Docker
   Desktop may be the easiest choice, depending on platform, but is not needed
   so long as you have the engine.
2. Create a new Twitch account for your bot, or decide to use your own.
3. Log into the Twitch account you'll be using for your bot and generate an
   oauth token for it with [this site](https://twitchapps.com/tmi/). Write this
   token down, you'll need it soon.
4. Create a folder on your machine to store the Compose configuration in, with:
   1. The docker-compose.yml from this repository
   2. queso.env.sample from this repository, renamed to queso.env
   3. An empty folder named "config"
5. Edit queso.env as necessary. The key values to change are USERNAME, PASSWORD,
   and CHANNEL. Set the username to the username you decided on in step 2, the
   password to the oauth token you wrote down in step 3, and the channel to your
   own twitch username (where you want to be using the bot).
   - There may be other settings you want to adjust as well. Of particular note
     is the LEVEL_SELECTION setting, which has a unique format; make sure that
     the entire setting is enclosed in single quotes(`'`), and each option uses
     double quotes (`"`).
6. Once queso.env is properly configured, start the container. In a terminal (or
   command prompt) window, you can do this with either `docker compose up` or
   `docker-compose up` (depending on your system configuration, either may work).
   Make sure there are no error messages printed out on screen, and then pop into
   your Twitch chat to test out the bot (try !adding a level code, try !list).
7. If everything looks good, you can leave the bot running in that window, or
   you can stop it with Ctrl+C and then run it in the background ("detached") by
   using `docker compose up -d` and stop it with `docker compose stop` (with or 
   without the dash, as above).
8. If you need to change any of the configuration values, then after stopping
   the container, run `docker compose rm -v` to remove the container and its
   anonymous volume, forcing the configuration to be regenerated the next time
   it starts.
9. When a new update is released, first stop and remove the container with the
   command `docker compose down -v` and then update it with `docker compose pull`.
   The container and configuration will then be rebuilt the next time you start
   it, using the updated version of the container.

## Advanced use

The container is fairly simple, so not much advanced use above the previously
documented steps is possible, and any such advanced use is not supported.

Nonetheless, this section will discuss some of the implementation details of the
container, and some unsupported ways of using the container.

The bot source is not part of this repository. When the container is built, it
pulls a specific commit specified by the `REF` argument. If you're building the
container yourself, you will need to provide this argument; this could be useful
if you need a specific version that was not built and published to Docker hub.

This container uses environment variables to generate a configuration file the
first time you start the container. This overwrites the `settings.js` file that
comes with the bot source, and it writes a `configured.txt` file next to it to
track that this initial configuration has been completed. While all options in
settings.js are exposed through the environment, it is possible to manually make
a settings.js file and bind mount it to the container, just make sure to also
mount a configured.txt file (the contents don't matter). This also means that
you can regenerate the config by deleting configured.txt from `/srv/queso` within
the container, to update it without removing the container.

The files in the `config` directory are symbolically linked to files within the
container, to persist the information in those files between container shutdowns.
This folder is checked for by the entrypoint script, which also generates the
settings as described above. If, for any reason, you need to mount those files
directly, then as long as you mount settings.js directly, you can bypass the
entrypoint script by specifying your own in the Compose config. How to do this
is left as an exercise for the reader, and I would recommend running the bot
directly from source rather than proceeding with this method.