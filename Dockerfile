# Base image
FROM fusenet/avail-node:1.0.2

# Default environment variables
ENV NETWORK=
ENV AVAIL_EVM_ADDRESS=
ENV AVAIL_CHECK_NFT_INTERVAL=
ENV AVAIL_COMISSION_RATE=
ENV AVAIL_OPERATOR_NAME=
ENV AVAIL_REWARD_COLLECTOR_ADDRESS=
ENV EXTRA_FLAGS=

# Copy entrypoint.sh file
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Gran executable permissions
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Entrypoint
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
