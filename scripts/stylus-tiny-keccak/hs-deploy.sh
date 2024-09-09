#!/bin/bash
set -e
source .env

cd hash-storage/stylus

cargo build --release --target wasm32-unknown-unknown --features tiny-keccak

cargo stylus deploy \
  --private-key "$ACCOUNT_PRIVATE_KEY" \
  --no-verify --endpoint "$RPC_URL" \
  --wasm-file target/wasm32-unknown-unknown/release/stylus_hash_storage.wasm