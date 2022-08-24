# General commands for BASH

## Get all OS updates -- use with caution!!

```bash
sudo -- sh -c 'apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y';sudo reboot
```

## Create alias

```bash
alias log="cd /var/log/snowstorm/"
alias db="cd /opt/snowstorm/NO/SNOMEDCT-NO"
alias snow="cd /opt/snowstorm/"
```

## Apply alias for all users

```bash
sudo vi /etc/profile.d/alias.sh
```

## Reboot machine

```bash
sudo /sbin/shutdown -r +5 >/dev/null 2>&1
```

## Bashrc at start up

```bash
sudo vi /etc/bash.bashrc
```

## Find lastest file in directory

```bash
unset -v latest
dir=$1
for file in "$dir"/\*; do
[[$file -nt $latest]] && latest=$file
done
```

## Get diff

```bash
diff -u conceptIds_export conceptIds | grep '^\+' | sed -E 's/^\+//' > diff
```

## Get similarities

```bash
fgrep -xf Concept_procedures_5.txt Concept_delta_25-5.txt
```

## Get column 1 from spreadsheet

```bash
cut -f1 mpf_mp_multiple.csv
or
awk '{ print $1 }' mpf_mp_multiple.csv
```

## Read column 1 starting from row 2

```bash
awk 'NR!=1 { print $1 }' Concept_procedures_5.txt
```

## Filter uniques values X in column Y

```bash
awk -F'\t' '!seen[$6]++ { print $1,"\011"$28 }' "file.txt"
```

## VIM - search and replace all - backslah to escape char

```bash
:%s/[old]/[new]/g
```

## Create symbolic link

```bash
sudo ln -fs /etc/nginx/sites-available/[server_fqdn] /etc/nginx/sites-enabled/
```

## Regex hitta alla meningar som INTE har 2021

```bash
^(?!._2021)._$
```

## Regex för UUID

```bash
egrep '[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}' -o
```

## Delete/ta bort lines rader i vim

```bash
:1,$d
```

## Syntax to save to var

```bash
var=$(awk '{ print $1 }' file.txt)
```

## Print tab-separated or comma-separated files

```bash
awk -F'\;' '{ print $1 }'
awk -F'\t' '{ print $1 }'
```

## Line count

```bash
Wc -l fil.txt
wc -l | grep -Eo '[0-9]{1,9}' >> out.txt
wc -l file.txt | awk '{print ($0+0)}'
```

## Curl with cookie

```bash
curl --cookie-jar cookies.txt -H 'Accept: application/json' -H "Content-Type: application/json" https:[url]/api/authenticate --data '{"login":"","password":"","rememberMe":"false"}'
```

## Add num of cols to same row, num of cols=num of rows

```bash
paste -d "," - - - - - < proc\*.txt << tags.txt
```

## Find exact matches (-x), print only num of rows(-c)

```bash
grep -cxf out.txt test.txt
```

## Find all files with .zip

```bash
find /opt/snowstorm/ -name '\*.zip'
```

## If condition for files with certain name

```bash
if [ -f 2022-01-05* ]; then
fi
```

## Logga in med ssh på azure

ssh -i [key_loc] [user]@[server_fqdn]

## copy files

```bash
scp -i [key_loc] [user]@[server_fqdn] /Users/oskar/Documents/
```

## Mvn skip tests

```bash
mvn clean install -DskipTests=true
mvn clean package -DskipTests=true
```

## VIM - search and replace all - backslash to escape char

```bash
:%s/[old]/[new]/g
```

## Search and replace slash med - i strängar

```bash
cat branches.txt | sed -e 's/\#-/g' > out2.txt
```

## Count uniques

```bash
uniq -c
```

## While loop syntax - read file

```bash
while read p; do
  echo "$p"
done <peptides.txt
```

## Remove files that don't have a certain file type/extension

```bash
ls "spring.log."\* |grep -v .gz|while read f; do sudo rm "$f"; done
```

## Save all output including errors until the bash session is ended

```bash
<cmd> <args> > <file> 2>&1
```

## Copy contents to clipboard

```bash
sudo apt install xclip xsel
xclip -selection clipboard < file.txt
```

## Build multiline email, e.g. for statuses

```bash
cat << EOF > results/$(date +"%d-%m-%Y")/error_log.txt
To: oskar@example.com
From: status@example.com
Subject: Notification

Hello World
EOF
```

## See all mails

```bash
mailq
```

## Empty inbox

```
sudo postsuper -d ALL
```
