#!/bin/bash

# ------------- #
# Configuration #
# ------------- #

# Load variables from .env file
set -o allexport
source scripts/.env
set +o allexport

# Helper constants
DEPLOYMENT_TX_DATA_FILE=deployment_tx_data
ACTIVATION_TX_DATA_FILE=activation_tx_data
DEPLOY_CONTRACT_RESULT_FILE=create_contract_result


# -------------- #
# Initial checks #
# -------------- #
if [ -z "$RPC_URL" ] || [ -z "$PRIVATE_KEY" ]
then
    echo "You need to provide the RPC_URL and the PRIVATE_KEY of the deployer"
    exit 0
fi

if [ -z "$PROXY_CONTRACT_ADDRESS" ] || [ -z "$PROXY_ADMIN_ADDRESS" ]
then
    echo "PROXY_CONTRACT_ADDRESS or PROXY_ADMIN_ADDRESS are not set"
    echo "You can run the script by setting the variables at the beginning: PROXY_CONTRACT_ADDRESS=0x PROXY_ADMIN_ADDRESS=0x updateLogic.sh"
    exit 0
fi

# ----------------------------- #
# Deployment of new Rust ERC-20 #
# ----------------------------- #
echo ""
echo "----------------------------------"
echo "Deploying new Rust ERC-20 contract"
echo "----------------------------------"

# Move to nft folder
cd erc20-rust

# Prepare transactions data
cargo stylus deploy -e $RPC_URL --private-key $PRIVATE_KEY > $DEPLOY_CONTRACT_RESULT_FILE

# Get contract address (the "sed" command removes the color codes of the output)
# (Note: sed regex obtained from https://stackoverflow.com/a/51141872)
erc20_contract_address=$(cat $DEPLOY_CONTRACT_RESULT_FILE | grep -E 0x | head -1 | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g' | grep -Eo '\b0x\w*')
rm $DEPLOY_CONTRACT_RESULT_FILE

# Final result
echo "ERC-20 contract deployed and activated at address: $erc20_contract_address"

# -------------------------------- #
# Updating logic contract on proxy #
# -------------------------------- #
echo ""
echo "--------------------------------"
echo "Updating logic contract on proxy"
echo "--------------------------------"

cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $PROXY_ADMIN_ADDRESS "upgradeAndCall(address,address,bytes)()" $PROXY_CONTRACT_ADDRESS $erc20_contract_address 0x

echo "Proxy $PROXY_CONTRACT_ADDRESS was updated to implementation in $erc20_contract_address"

# PROXY_CONTRACT_ADDRESS= PROXY_ADMIN_ADDRESS= ./scripts/updateLogic.sh