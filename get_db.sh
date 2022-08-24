#!/bin/bash
# Fetches the db from SI's s3 bucket. Call script with the bucket location uri.

BUCKET_LOC="$1"
aws s3 ls "$BUCKET_LOC" | awk '{print $4}' > ./awsls.txt
while read line; do
        if [ ! -f ./NO/SNOMEDTC-NO/"$line" ]; then
                echo "Starting download of "$line""
                aws s3 cp "$BUCKET_LOC""$line" ./NO/SNOMEDCT-NO/ > /dev/null 2>&1
                echo "Fetched "$line""
                echo ""
        fi
done < awsls.txt
rm awsls.txt