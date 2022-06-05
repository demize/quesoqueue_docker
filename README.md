# Queso Queue Docker

This repository is a Dockerfile, supporting files, and an example `queso.env`
and `docker-compose.yml` for Shoujo's [Queso Queue Plus][qqpgithub] project.

[qqpgithub]: https://github.com/ToransuShoujo/quesoqueue_plus

# Using the container

Docker Compose is the easiest way to use this container, so this brief guide to
using the container will focus on using Compose. First, create `queso.env` from
`queso.env.sample`, and edit it as appropriate. This file is used to generate a
custom [`settings.js`][settings.js] file on the container's first startup, which
is then kept in the container's volume. Second, you want to make sure that the
folder mounted to `/srv/queso/config` exists and is at least read/write for UID
1000, the UID of the node user inside the container. By default, this folder is
in the same directory as this README and the docker-compose.yml, but if you need
to put it somewhere else, feel free to edit the path in the Compose file.

Once your `queso.env` is created and your config folder is set up properly, you
can start the container: `docker compose up`. This will start the container and
refrain from detaching from it, so you can be sure the bot started properly. To
stop the bot, just hit Control+C, and then restart it with `docker compose up -d`
to detach from it and let it run in the background.

Since the bot does some initial configuration in its ephemeral volume the first
time it starts, it is not recommended to stop the bot with `docker compose down`.
This will remove the container's volume, making it redo that initial setup. This
also means that if you change any settings in the `queso.env` file, you need to
remove that volume to regenerate those settings, and you can do that easily
through `docker compose down`. Any other times you wish to stop the bot, you'll
be best served with `docker compose stop` instead.

[settings.js]: https://github.com/ToransuShoujo/quesoqueue_plus/blob/master/settings.js