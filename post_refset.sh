#!/usr/bin/env bash

# Usecase: Push data to the POST refsets endpoint. 
#          Below is a simple refset, tweak it as necessary 
#          (e.g. use "cut -f" for fetching columns for complex maps).
# At the time of writing there is no POST batch refsets endpoint.
# Example:
# ./post_refset "https://example.com/MAIN%2FSNOMEDCT-NO%2FREFSETS" "Bearer ey123.." "MAIN/SNOMEDCT-NO" "my_refsets.txt"

BASE_URL="$1"
AUTH="$2"
BRANCH="$3"
INPUT_FILE="$4"

if [ $# != 4 ]; then
  echo "Has to be 4 args in this order: BASE_URL="$1" AUTH="$2" BRANCH="$3" INPUT_FILE="$4""
  exit 0
fi

while read line; do
  if [ "$line" != "" ]; then
    curl -sX POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'Authorization: '"$auth" -d \ 
    '{
      "active": true,
      "additionalFields": {},
      "moduleId": "[insert_module_id]",
      "referencedComponentId": '"$line"',
      "refsetId": "[insert_refsetId]"
    }' "$BASE_URL"'/members'
  fi
done < "$INPUT_FILE"
