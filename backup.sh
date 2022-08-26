#!/bin/bash

source .env

DATE=$(date +%Y-%m-%d-%H-%M)
DATA_DIR="$NEAR_DIR/data"

mkdir -p $BACKUP_DIR

# Remove old backups
echo "Remove old files" | ts
find ${BACKUP_DIR} -mindepth 1 -mtime +${MAX_DAYS} -delete

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUP_DIR" ]; then
    echo "Backup started" | ts

    # Skip compression because too long
    tar -C ${DATA_DIR} -cvf ${BACKUP_DIR}/near_${DATE}.tar .

    # Submit backup completion status
    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/${HC_PING}/$?

    echo "Backup completed" | ts
else
    echo "$BACKUP_DIR is not created. Check your permissions."
    exit 1
fi

sudo systemctl start neard

echo "NEAR node was started" | ts

