# DAppNodePackage - node-sale-fuse-l2

 GitHub repository used to store DAppNode community package to participate in Node Sale Fuse L2. Shortly package helps to run Avail light client for Fuse L2 networks - Flash (testnet) and Ember (mainnet).

 Package is relying on Avail light client, which was modified for Fuse L2 - https://github.com/fuseio/avail-light, branch `fuse-client`.

 More details about DAppNode platform and DAppNodeSDK provided [here](https://docs.dappnode.io/docs/user/getting-started/choose-your-path/) and [here](https://docs.dappnode.io/docs/dev/sdk/overview).


## Develop, Build & Publish

 1. Install `nvm`:

 ```bash
 curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
 ```
 
 2. Configure NodeJS 18:

 ```bash
 nvm install 18
 ```

 3. Install DAppNode SDK with `npm`:

 ```bash
 npm i @dappnode/dappnodesdk
 ```

 4. Develop DAppNode pacakge by modifying Dockerfile, docker-compose.yml files and so on;

 5. Build & publish package:

 ```bash
 # Note: by default remote IPFS provider is https://gateway-dev.ipfs.dappnode.io
 dappnodesdk build --provider remote
 ```

 Latest command will generate IPFS hash in console and generate new version of `releases.json` file.

## Install

 1. First, need to install DAppNode platform by following this [guide](https://docs.dappnode.io/docs/user/install/script);

 2. Then connect to the DAppNode platform by configuring [WireGuard](https://docs.dappnode.io/docs/user/access-your-dappnode/vpn/wireguard) VPN solution and access http://my.dappnode endpoint;

 3. Initialize DAppNode platform by providing your personal credentials;

 4. Go to the `Repository` -> `IPFS` and configure https://gateway-dev.ipfs.dappnode.io endpoint;

 5. From `releases.json` file use IPFS hash and paste it to `DAppStore` search bar;

 6. In `Advanced options` pick `Bypass only signed safe restriction` and start install process.
