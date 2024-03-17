#!/bin/bash

echo "Syncing personal vault to koofer-safe-box. "
echo ""

rclone sync --progress /mnt/Data/Backup/PersonalVault my-safe-box:
