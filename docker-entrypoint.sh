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
elif [ -z "${CHECK_NFT_INTERVAL}" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: CHECK_NFT_INTERVAL is unset or set to the empty string.
    exit 1
elif [ -z "${COMISSION_RATE}" ]; then
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") ERROR docker-entrypoint.sh: COMISSION_RATE is unset or set to the empty string.
    exit 1
else
    # Output environment variable(s) value(s)
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: L2 network - $NETWORK
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Interval to check NFT - $CHECK_NFT_INTERVAL ms
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Comission rate - $COMISSION_RATE %
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Operator name - dappnode_operator
    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Reward collector address - $REWARD_COLLECTOR_ADDRESS
fi

# Identify the network and generate config.yaml file
if [ $NETWORK == "Flash" ]; then

    echo $(date -u +"%Y-%m-%dT%H:%M:%S.%6NZ") INFO docker-entrypoint.sh: Generating config.yaml file...

    cat <<EOF >config.yaml
# File system path where RocksDB used by light client, stores its data. (default: avail_path)
avail_path = "/data"
# Log level
log_level = "info"
# Light client HTTP server host name (default: 127.0.0.1)
http_server_host = "0.0.0.0"
# Light client HTTP server port (default: 7007).
http_server_port = 7007
# P2P TCP listener port (default: 37000).
port = 37000 
# P2P WebRTC listener port (default: 37001).
webrtc_port = 37001
# WebSocket endpoint of a full node for subscribing to the latest header, etc (default: ws://127.0.0.1:9944).
full_node_ws = ["ws://0.0.0.0:9944"]
# ID of application used to start application client. If app_id is not set, or set to 0, application client is not started (default: 0).
app_id = 22
# Starting block of the syncing process. Omitting it will disable syncing. (default: None).
sync_start_block = 1
# Genesis hash of the network you are connecting to. The genesis hash will be checked upon connecting to the node(s) and will also be used to identify you on the p2p network. If you wish to skip the check for development purposes, entering DEV{suffix} instead will skip the check and create a separate p2p network with that identifier.
genesis_hash = "DEVTST"
# identity.toml private key
avail_secret_key = "bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice"
# NFT check - Endpoint
check_nft_endpoint = "https://monitoring.avail.fuse.io/check-nft"
# NFT check - Interval
check_nft_interval = $CHECK_NFT_INTERVAL
# Comission rate
commission_rate = "$COMISSION_RATE"
# Operator's name
operator_name = "dappnode_operator"
# Public reward collector address
reward_collector_address = "$REWARD_COLLECTOR_ADDRESS"
# Private key which's holding / delegating NFT
private_key = "$PRIVATE_KEY"
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
/usr/bin/avail-node --config config.yaml --network mainnet $EXTRA_OPTS &

# Wait main process
wait $!
