#!/usr/bin/env bash
# Useful for executing a command on a cluster of VMs. Assumes you have a ssh key and prepared a saved list of servers as input.  
# Example: 
# ./cmd_servers.sh "~/ssh_key.pem" "servers.txt" "cd /home/azureuser/sct-browser-frontend && git checkout master && git stash && git pull && git stash pop && grunt"

KEY="$1"
SERVERS="$2"
CMD="$3"
[[ $# -ne 3 ]] && echo "3 params required: KEY="$1" SERVERS="$2" CMD="$3" "

while read line; do
    ssh -i "$KEY" -n "$line" " "$CMD" "
    echo "Finished "$line""
done <"$SERVERS"
echo "Done."