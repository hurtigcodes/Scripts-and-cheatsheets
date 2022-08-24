#!/usr/bin/env bash
# For converting csv, tsv or other types of text files to an RF2 file compliant structure.
# Comment: Yes, I insisted to experiment with associative arrays :-)

INPUT="$1"
CONFIG="$2"
SEM_FILE="$(dirname "$INPUT")/no_head_tmp.tsv"
RES_FILE="$(dirname "$INPUT")/res_tmp.txt"
# RES_FILE_UTF8="$(dirname "$INPUT")/res_utf8.txt"
tail +2 "$INPUT" > "$SEM_FILE"
unset colNum;declare -A colNum

for key in $(jq -r 'keys_unsorted[]' "$CONFIG"); do # TODO: Get all element with .map directly...
    var=$(jq -r '.'"$key"'.map' "$CONFIG" 2> /dev/null|sed -e 's/(/\\(/g'|sed -e 's/)/\\)/g')  # TODO: Better sed
    if [[ -n "$var" ]]; then
        colNum["$(echo "$key")"]=$(head -1 "$INPUT"|awk -v RS='\t' '/'"$var"'/{print NR; exit}')
    fi
done

jq -r 'keys_unsorted | @tsv' "$CONFIG" > "$RES_FILE" # header first
while read -r line; do
    for key in $(jq -r 'keys_unsorted[]' "$CONFIG"); do
        if [[ ${colNum["$key"]} ]]; then
            echo -n $(echo "$line" | awk -F'\t' '{ print $'${colNum["$key"]}' }') >> "$RES_FILE"
        elif [[ $(jq -r '.'$key "$CONFIG") =~ "{{UUID}}"  ]]; then 
            echo -n $(uuidgen | tr "[:upper:]" "[:lower:]") >> "$RES_FILE"
        else 
            echo -n $(jq -r ."$key" "$CONFIG") >> "$RES_FILE"
        fi
        # If on last element in config loop, skip printing tab
        if [[ $(jq -r '.|keys_unsorted|last' "$CONFIG") != "$key" ]]; then
          echo -n $'\t' >> "$RES_FILE"
        fi
    done
done < "$SEM_FILE"

# If the machine gives you the wrong encoding, tweak as necessary
# iconv -f iso-8859-1 -t utf-8 "$RES_FILE" > "$RES_FILE_UTF8"
rm "$SEM_FILE" "$RES_FILE"
