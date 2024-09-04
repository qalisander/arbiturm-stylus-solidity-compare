#!/bin/bash
set -e
source .env

cd hash-storage-1000/stylus

cargo stylus deploy \
  --private-key "$ACCOUNT_PRIVATE_KEY" \
  --no-verify --endpoint "$RPC_URL"