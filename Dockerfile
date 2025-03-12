# Base image
FROM fusenet/avail-node:1.0.4

# Default environment variables
ENV NETWORK=
ENV PRIVATE_KEY=
ENV REWARD_COLLECTOR_ADDRESS=
ENV AVAIL_CHECK_NFT_INTERVAL=
ENV AVAIL_COMISSION_RATE=
ENV AVAIL_OPERATOR_NAME=
ENV EXTRA_FLAGS=

# Copy entrypoint.sh file
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Gran executable permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
