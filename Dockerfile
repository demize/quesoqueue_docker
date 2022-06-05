FROM node:18-alpine

# Which commit to pull
ARG REF

RUN mkdir -p /srv/queso \
    && wget -qO- https://github.com/ToransuShoujo/quesoqueue_plus/archive/${REF}.tar.gz \
    |  tar xzC /srv/queso --strip-components 1 \
    && chown -R node:node /srv/queso

# Run as the node user
USER node

# Set the base application directory
WORKDIR /srv/queso

# Install the dependencies
RUN npm install

# Set up the rest of the filesystem
COPY --chown=node:node entrypoint.sh settings.sh ./
RUN chmod +x ./entrypoint.sh ./settings.sh

ENTRYPOINT [ "./entrypoint.sh" ]