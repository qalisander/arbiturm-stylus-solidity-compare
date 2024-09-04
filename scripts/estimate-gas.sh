#!/bin/bash
set -e
source .env

cast estimate "$DEPLOYMENT_ADDRESS" \
  --rpc-url "$RPC_URL" \
  "storeHash(string)" "abc"
