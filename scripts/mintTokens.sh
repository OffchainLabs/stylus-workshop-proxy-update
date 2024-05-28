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

if [ -z "$PROXY_CONTRACT_ADDRESS" ] || [ -z "$RECEIVER_ADDRESS" ]
then
    echo "PROXY_CONTRACT_ADDRESS or RECEIVER_ADDRESS are not set"
    echo "You can run the script by setting the variables at the beginning: PROXY_CONTRACT_ADDRESS=0x RECEIVER_ADDRESS=0x mintTokens.sh"
    exit 0
fi

# ----------------------------- #
# Deployment of new Rust ERC-20 #
# ----------------------------- #
echo ""
echo "---------------------"
echo "Minting ERC-20 tokens"
echo "---------------------"

cast send --rpc-url $RPC_URL --private-key $PRIVATE_KEY $PROXY_CONTRACT_ADDRESS "mint(address,uint256)()" $RECEIVER_ADDRESS 100

echo "100 tokens have been minted and transferred to $RECEIVER_ADDRESS"

# PROXY_CONTRACT_ADDRESS= RECEIVER_ADDRESS= ./scripts/mintTokens.sh