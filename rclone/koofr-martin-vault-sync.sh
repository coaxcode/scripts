#!/bin/bash

echo "Syncing personal vault to koofer-safe-box. "
echo ""

rclone sync --progress ~/PersonalVault mysafebox:
