#!/bin/bash
if [ -z "$ALICE_IP" ]
then
    ./node-template --base-path /tmp/$USER \
      --chain local \
      --$USER \
      --port $PORT \
      --ws-port $WS_PORT \
      --rpc-port $RPC_PORT \
      --telemetry-url $TELEMETRY_URL \
      --validator
else
    ./node-template --base-path /tmp/$USER \
      --chain local \
      --$USER \
      --port $PORT \
      --ws-port $WS_PORT \
      --rpc-port $RPC_PORT \
      --telemetry-url $TELEMETRY_URL \
      --validator
      --bootnodes /ip4/$ALICE_IP/tcp/$ALICE_PORT/p2p/QmViTYm8Yr4yneyRGov9L87vLeVLoySFduVRNQ1d33WdXN
fi