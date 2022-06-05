# Queso Queue Docker

This repository is a Dockerfile, supporting files, and an example `queso.env`
and `docker-compose.yml` for Shoujo's [Queso Queue Plus][qqpgithub] project.

[qqpgithub]: https://github.com/ToransuShoujo/quesoqueue_plus

# Using the container

Docker Compose is the easiest way to use this container, and the example Compose
file should be usable with a properly configured `queso.env` file. The variables
in that file are defined per the variables in the upstream `settings.js` file;
please refer to [that file][settings.js] for the documentation.

This container does need to mount a config folder to function. This folder
should be mounted to `/srv/queso/config` and does not need to contain anything
initially; it will be populated automatically on first start with four files:
customCodes.json (used to store custom codes), queso.save (used to store the queue
state), and userWaitTime.txt and waitingUsers.txt (used to keep track of how long
users have been waiting in the queue). If this folder is not mounted, the 
container will refuse to start.

[settings.js]: https://github.com/ToransuShoujo/quesoqueue_plus/blob/master/settings.js