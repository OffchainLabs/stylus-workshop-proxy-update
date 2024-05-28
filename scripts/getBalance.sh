#!/bin/bash

# ------------- #
# Configuration #
# ------------- #

# Load variables from .env file
set -o allexport
source scripts/.env
set +o allexport

# -------------- #
# Initial checks #
# -------------- #
if [ -z "$PROXY_CONTRACT_ADDRESS" ] 
then
    echo "PROXY_CONTRACT_ADDRESS is not set"
    echo "You can run the script by setting the variables at the beginning: PROXY_CONTRACT_ADDRESS=0x test.sh"
    exit 0
fi

echo "Get balance of $PUBLIC_ADDRESS"
balance=$(cast call --rpc-url $RPC_URL $PROXY_CONTRACT_ADDRESS "balanceOf(address)(uint256)" $PUBLIC_ADDRESS)
echo "Balance: $balance"

# PROXY_CONTRACT_ADDRESS= ./scripts/getBalance.sh