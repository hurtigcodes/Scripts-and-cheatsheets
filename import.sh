#!/bin/sh
# Automate RF2 file imports. Just call the script with filename (tip, absolute path) and complete branch path.
FILE_NAME="$1"
BRANCH="$2"
BASE_URL="http://localhost:8080" #no trailing slash

# Create importjob
id=$(curl -i -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
  "branchPath": "'$BRANCH'",
  "createCodeSystemVersion": false,
  "type": "DELTA"
}' "$BASE_URL"'/imports' 2> /dev/null | sed -n 's/Location: '"$BASE_URL"'\/imports\///p' )

# Remove whitespace
id="$(echo -e "${id}" | tr -d '[:space:]')"

url=$BASE_URL'/imports/'"$id"'/archive'

# Post file
curl -s -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' -F file=@"$FILE_NAME" $url 2> /dev/null

# Get status
sleep 1
curl -s -X GET "$BASE_URL"'/imports/'"$id" | jq . 2> /dev/null