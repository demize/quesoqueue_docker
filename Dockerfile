FROM node:18-alpine

# Since we're pulling a single ref, easiest to do with git
RUN apk add git

# Run as the node user
USER node

# Set the base application directory
WORKDIR /srv/queso

# Which commit to pull
ARG ref

# Pull the source code
RUN git init \
    && git remote add origin https://github.com/ToransuShoujo/quesoqueue_plus.git \
    && git fetch origin ${ref} \
    && git reset --hard FETCH_HEAD

# Install the dependencies
RUN npm install

# Set up the rest of the filesystem
COPY --chown=node:node entrypoint.sh .
COPY --chown=node:node settings.sh .
RUN chmod +x ./entrypoint.sh
RUN chmod +x ./settings.sh

ENTRYPOINT [ "./entrypoint.sh" ]