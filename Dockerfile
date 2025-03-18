# Specify upstream version
ARG UPSTREAM_VERSION

# Base image
FROM fusenet/avail-node:${UPSTREAM_VERSION}

# Default environment variables
ENV NETWORK=
ENV PRIVATE_KEY=
ENV REWARD_COLLECTOR_ADDRESS=
ENV CHECK_NFT_INTERVAL=
ENV COMISSION_RATE=
ENV EXTRA_OPTS=

# Copy entrypoint.sh file
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Gran executable permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
