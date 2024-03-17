#!/bin/bash

echo "Syncing Informator data to OneDrive-SDKrasnja. "
echo ""

rclone sync --progress /mnt/Data/OneDrive-SDKrasnja/ onedrive-sdkrasnja:Informator
