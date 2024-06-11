#!/bin/bash

echo "Syncing Informator data to OneDrive-SDKrasnja. "
echo ""

rclone sync --tpslimit 10 --progress ~/OneDrive-SDKrasnja/ onedrive-sdkrasnja:Informator
