#!/bin/bash

# Environment variable check
if [ -z "${NETWORK}" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: NETWORK is unset or set to the empty string.
    exit 1
elif [ -z "${PRIVATE_KEY}" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: PRIVATE_KEY is unset or set to the empty string.
    exit 1
elif [ -z "${REWARD_COLLECTOR_ADDRESS}" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: REWARD_COLLECTOR_ADDRESS is unset or set to the empty string.
    exit 1
else
    # Export default environment variables
    export CHECK_NFT_INTERVAL=${AVAIL_CHECK_NFT_INTERVAL:=300}
    export COMISSION_RATE=${AVAIL_COMISSION_RATE:=5}
    export OPERATOR_NAME=${AVAIL_OPERATOR_NAME:="DAppNode operator"}

    # Output default environment variable(s) value(s)
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Network - $NETWORK
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Interval to check NFT - $CHECK_NFT_INTERVAL
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Comission rate - $COMISSION_RATE
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Operator name - $OPERATOR_NAME
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Reward collection address - $REWARD_COLLECTOR_ADDRESS
fi

# Identify the network and generate config.yaml file
if [ $NETWORK == "Flash" ]; then

    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Generating config.yaml file...

    cat <<EOF >config.yaml
app_id = 22
sync_start_block = 1
genesis_hash = "DEVTST"
avail_secret_key = "bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice"
check_nft_endpoint = "https://monitoring.avail.fuse.io/check-nft"
check_nft_interval = $CHECK_NFT_INTERVAL
private_key = "$PRIVATE_KEY"
commission_rate = "$COMISSION_RATE"
operator_name = "$OPERATOR_NAME"
reward_collector_address = "$REWARD_COLLECTOR_ADDRESS"
EOF
elif [ $NETWORK == "Ember" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: Ember network is not supported right now. Stay tunned.
    exit 1
else
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: Unsupported network. Possible values: Flash, Ember.
    exit 1
fi

# Trapping SIGTERM
trap 'echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Received SIGTERM, shutting down...; exit 0' SIGTERM

# Run Avail light client
/usr/bin/avail-node --config config.yaml --network mainnet --avail-path /data $EXTRA_FLAGS &

# Wait main process
wait $!
