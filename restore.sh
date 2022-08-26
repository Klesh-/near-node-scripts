#!/bin/bash

source .env

DATE=$(date +%Y-%m-%d-%H-%M)
DATA_DIR="$NEAR_DIR/data"

if [ -z "$1" ]; then
    echo "No file specified"
    exit 1
fi

FILE="$1"

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -f "$FILE" ]; then
    echo "Rollback started" | ts

    mv ${DATA_DIR} "${DATA_DIR}_old_${DATE}"

    mkdir -p ${DATA_DIR}

    tar -C ${DATA_DIR} -xvf ${FILE}

    echo "Rollback completed" | ts

    echo "Old data saved at ${DATA_DIR}_old_${DATE}" | ts
else
    echo "$FILE is not exists."
    exit 1
fi

sudo systemctl start neard

echo "NEAR node was started" | ts

