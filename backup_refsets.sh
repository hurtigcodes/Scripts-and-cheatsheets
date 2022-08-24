#!/bin/bash
# Script will attempt to save an export of a branch. Useful for saving a refset. 
# Tweak the request body if you want to only save specific refset(s)

BASE_URL="localhost:8080/snowstorm/snomed-ct/exports"
WORK_FOLDER="/opt/snowstorm/NO/SNOMEDCT-NO/Exports"
BRANCH="$1"
BRANCH_NO_SLASH=$(echo $BRANCH | sed -e 's/\//-/g') # replaces "/" with "-"
id=$(curl -siX POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
  "branchPath": "'$BRANCH'",
  "type": "DELTA",
  "unpromotedChangesOnly": true
}' "$BASE_URL"| grep -i location | grep -Eo '[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}')

sudo wget -qO ""$WORK_FOLDER"/"$BRANCH_NO_SLASH"_$(date '+%Y-%m-%d').zip" "$BASE_URL"/"$id"/archive

# remove >1 month old exports (suitable for crontab)
sudo rm $(find "$WORK_FOLDER"/*.zip -mtime +31)