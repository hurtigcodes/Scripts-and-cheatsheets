#!/usr/bin/env bash
# Attempts to place a TSV file (a map in this example) and zip an RF2 archive using a clean RF2 folder with the necessary subfolders and files. Useful in combination with other scripts :-).
# Example: 
# ./rf2_zip.sh "/Users/oskar/Snomed/clean-rf2-folder/" "/Users/oskar/Snomed/example.tsv" "Map"
INPUT_RF2_PATH="$1"
TSV_PATH="$2"
RF2_SUBFOLDER="$3"
OUTPUT_RF2_NAME="generated_RF2-"$(shuf -i 1-100000 -n 1)
OUTPUT_RF2_PATH="$(dirname "$INPUT_RF2_PATH")/"$OUTPUT_RF2_NAME""

cp "$INPUT_RF2_PATH" "$OUTPUT_RF2_PATH"
cp "$TSV_PATH" ""$INPUT_RF2_PATH"/"$RF2_SUBFOLDER"/RF2_map.txt"
zip -r "$OUTPUT_RF2_PATH"