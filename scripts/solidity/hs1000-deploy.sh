#!/bin/bash
set -e
source .env

forge create --rpc-url "$RPC_URL" \
  --private-key "$ACCOUNT_PRIVATE_KEY" \
   "hash-storage-1000/solidity/hash-storage-1000.sol:HashStorage1000"
