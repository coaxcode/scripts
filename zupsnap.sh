#!/bin/bash

# zupsnap.sh will upgrade openSUSE Tumbleweed and modify description of created
# snapshots (pre,post) to release version id's.

if [ ! -x "$(command -v jq)" ]
then
    echo "Please install jq"
    exit
fi

if  [ $EUID -ne 0 ]
then
    echo "Please run as root"
    exit
fi

UNIX_DATE=$(date +%s)
SNAPPER_LIST_FILE="/tmp/zupsnap-${UNIX_DATE}"
SNAPPER_CURRENT_VERSION_ID=$(cat /etc/os-release | grep VERSION_ID | cut -d'"' -f 2)

echo "Running 'snapper list'"
snapper --jsonout list > $SNAPPER_LIST_FILE

SNAPPER_LAST_ID=$(jq '.root[-1].number' $SNAPPER_LIST_FILE)
echo -e "Done!\nLast snapshot ID before upgrade was ${SNAPPER_LAST_ID}"

echo "Running upgrade.."
zypper ref && zypper dup

if [ -x "$(command -v flatpak)" ]
then
    flatpak update
else
    echo "flatpak not installed.. skipping."
fi

echo "Modifying snapshot description"
SNAPPER_PRE_ID=$((SNAPPER_LAST_ID + 1))
SNAPPER_POST_ID=$((SNAPPER_LAST_ID + 2))

snapper modify -d "${SNAPPER_CURRENT_VERSION_ID}" $SNAPPER_PRE_ID
SNAPPER_CURRENT_VERSION_ID=$(cat /etc/os-release | grep VERSION_ID | cut -d'"' -f 2)
snapper modify -d "${SNAPPER_CURRENT_VERSION_ID}" $SNAPPER_POST_ID

echo "All done!"
