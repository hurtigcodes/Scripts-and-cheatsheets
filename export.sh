#!/bin/bash
# This creates an RF2 file export. Obviously, tweak request body as needed as well as the file names below. 
BASE_URL="localhost:8080/exports"
WORK_FOLDER="/opt/snowstorm/NO/SNOMEDCT-NO/Exports"

id=$(curl -siX POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
 "branchPath": "MAIN/SNOMEDCT-NO",
  "moduleIds": [
    "57101000202106","57091000202101","51000202101"
  ],
  "type": "SNAPSHOT",
  "unpromotedChangesOnly": false
}' "$BASE_URL"| grep -Eo '[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}')

wget -qO ""$WORK_FOLDER"/NorwegianModules_SNAPSHOT_$(date '+%Y-%m-%d').zip" "$BASE_URL"/"$id"/archive
# remove yesterday's
[ -s ""$WORK_FOLDER"/NorwegianModules_SNAPSHOT_$(date '+%Y-%m-%d').zip" ] && rm ""$WORK_FOLDER"/NorwegianModules_SNAPSHOT_$(date --date="yesterday" +"%Y-%m-%d").zip"