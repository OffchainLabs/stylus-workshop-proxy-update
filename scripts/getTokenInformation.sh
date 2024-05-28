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

echo "Get token information"
token_name=$(cast call --rpc-url $RPC_URL $PROXY_CONTRACT_ADDRESS "name()(string)")
echo "Name: $token_name"

token_symbol=$(cast call --rpc-url $RPC_URL $PROXY_CONTRACT_ADDRESS "symbol()(string)")
echo "Symbol: $token_symbol"

token_decimals=$(cast call --rpc-url $RPC_URL $PROXY_CONTRACT_ADDRESS "decimals()(uint256)")
echo "Decimals: $token_decimals"

# PROXY_CONTRACT_ADDRESS= ./scripts/getTokenInformation.sh