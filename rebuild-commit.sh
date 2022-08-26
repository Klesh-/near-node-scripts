#!/bin/bash
source .env

if [ -z "$1" ]; then
    echo "Invalid commit"
    exit
fi

DIR=$(pwd)
cd $NEAR_CORE_DIR \
    && git fetch && git checkout $1 \
    && cargo build -p neard --release --features shardnet \
    && cd $DIR
