#!/bin/bash
set -e
source .env

cargo stylus cache bid \
  --private-key "$ACCOUNT_PRIVATE_KEY" --endpoint "$RPC_URL" \
  "$DEPLOYMENT_ADDRESS" 0