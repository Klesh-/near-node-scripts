# near-node-scripts
A simple set of scripts to work with near protocol node

### Requirements
```sh
apt install moreutils
```

# Setup

### Copy .env.example to .env
```sh
cp .env.example .env
```

### Fill script parameters in .env file
- **NEAR_DIR** - Near home directory (`/root/.near`)
- **NEAR_DIR_BACKUP** - Near home directory of backup node (`/root/.near-backup`)
- **NEAR_CORE_DIR** - Nearcore sources directory (it's where you `git clone nearcore`)
- **NEAR_KEYS_DIR** - Near validator and reserve keys directory
- **BACKUP_DIR** - Directory to store backup files
- **BACKUP_MAX_DAYS** - Max backup files retention days
- **HC_PING** - https://healthchecks.io/ ping url

#### NEAR_KEYS_DIR
Directory structure
```
NEAR_KEYS_DIR
├── reserve
│   ├── node_key.json
│   └── validator_key.json
└── validator
    ├── node_key.json
    └── validator_key.json

2 directories, 4 files
```

### Add cron job
```sh
crontab -e
Paste:
0 12 * * * /path/to/backup.sh >> path/to/backups/backup.log 2>&1
```

# Stake Wars: Episode III. Challenge 014
https://github.com/near/stakewars-iii/blob/main/challenges/014.md
