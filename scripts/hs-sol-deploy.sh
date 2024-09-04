#!/bin/bash
set -e
source .env

forge create --rpc-url "$RPC_URL" \
  --private-key "$ACCOUNT_PRIVATE_KEY" \
  "hash-storage/solidity/hash-storage.sol:HashStorage"
