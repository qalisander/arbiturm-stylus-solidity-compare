#!/bin/bash
set -e
source .env

./nitro-testnode/test-node.bash script send-l2 \
  --to "address_$ACCOUNT_ADDRESS" \
  --ethamount 10000
