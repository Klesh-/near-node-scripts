#!/bin/bash
source .env

systemctl stop neard \
    && mv $NEAR_DIR/data $NEAR_DIR/data-fork-$(date +"%d-%m-%Y-%H_%M_%S") \
    && rm $NEAR_DIR/config.json \
    && wget -O $NEAR_DIR/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json \
    && rm $NEAR_DIR/genesis.json \
    && wget -O $NEAR_DIR/genesis.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/genesis.json
