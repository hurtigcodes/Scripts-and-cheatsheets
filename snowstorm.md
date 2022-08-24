# Commands for Snowstorm

## Get FSNs

```bash
grep -o "(._)" fsn.txt | sed 's/._(\(.\*\))/\1/' > semantictags.txt
```

## Full integrity report Snowstorm

```bash
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' 'localhost:8080/snowstorm/snomed-ct/MAIN%2FSNOMEDCT-NO/integrity-check-full'
```

## Check DB

check `get_db.sh` 😊

## Use the delta service generator, example

```bash
/usr/bin/java -jar ~/DeltaGeneratorTool.jar 20210731 /opt/snowstorm/NO/SNOMEDCT-NO/releases/xSnomedCT_InternationalRF2_MEMBER_20220131T120000Z.zip
```
