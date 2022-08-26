#!/bin/bash

source .env

SIDE="$1"

if [ "${SIDE}" = "main" ]; then
    echo "Stopping main node..."
    systemctl stop neard
    echo "Stopping backup node..."
    systemctl stop neard-backup

    echo "Replacing main node keys with validator keys..."
    cd $NEAR_DIR
    rm validator_key.json node_key.json
    cp $NEAR_KEYS_DIR/validator/validator_key.json $NEAR_KEYS_DIR/validator/node_key.json .

    echo "Replacing backup node keys with reserve keys..."
    cd ~/.near-backup
    rm validator_key.json node_key.json
    cp $NEAR_KEYS_DIR/reserve/validator_key.json $NEAR_KEYS_DIR/reserve/node_key.json .

    echo "Launching main node..."
    systemctl start neard

    exit 0
fi

# Switch to backup node
if [ "${SIDE}" = "backup" ]; then
    echo "Switch to backup node"

    echo "Stopping main node..."
    cd $NEAR_DIR
    cat node_key.json | grep "public_key"
    systemctl stop neard

    echo "Replacing main node keys with reserve keys..."
    rm validator_key.json node_key.json
    cp $NEAR_KEYS_DIR/reserve/validator_key.json $NEAR_KEYS_DIR/reserve/node_key.json .
    cat node_key.json | grep "public_key"

    echo "Launching backup node..."
    cd $NEAR_DIR_BACKUP
    cat node_key.json | grep "public_key"
    systemctl stop neard-backup

    echo "Replacing backup node keys with validator keys..."
    rm validator_key.json node_key.json
    cp $NEAR_KEYS_DIR/validator/validator_key.json $NEAR_KEYS_DIR/validator/node_key.json .
    cat node_key.json | grep "public_key"

    systemctl start neard-backup

    exit 0
fi

echo "Invalid side, Choose 'main' or 'backup'"
exit 1

