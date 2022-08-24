# Useful jq commands

## Get data that DO NOT have a certain key

```bash
curl -X GET --header 'Accept: application/json' --header 'Accept-Language: en-X-900000000000509007,en-X-900000000000508004,en' 'localhost:8080/snowstorm/snomed-ct/MAIN%2FSNOMEDCT-NO%2FREFSETS/members?referenceSet=88791000202108&offset=0&limit=9999' \
|jq -r '.items | map(select(.referencedComponent == null))'

curl -X GET --header 'Accept: application/json' --header 'Accept-Language: en-X-900000000000509007,en-X-900000000000508004,en' 'localhost:8080/MAIN%2FSNOMEDCT-NO%2FSLVMAPS%2FVSOPOST/members?referenceSet=12311000202102&offset=0&limit=9999' \
|jq -r '.items | map(select(.referencedComponent == null))'
```

## Parse JSON and put in brackets

```bash
curl -s 'localhost:8080/browser/MAIN/SNOMEDCT-NO/descriptions?module=51000202101&type=900000000000003001&limit=5000'|jq -r '[.buckets.semanticTags]'
```

## Parsa JSON och change names of columns

```bash
curl -s 'localhost:8080/browser/MAIN/MIG-STATS/PROSEDYRER/PROSEDYRER-5/descriptions?module=51000202101&type=900000000000003001&limit=5000'|jq -r '[.buckets.module|.["Total:"] = ."51000202101"|del(."51000202101")]'
curl -s 'localhost:8080/branches/MAIN%2FMIGRATION/children?immediateChildren=true&page=0&size=100'|jq -r '.[].path'
```

## Get conceptId from browser view

```bash
curl 'localhost:8080/browser/MAIN%2FSNOMEDCT-NO/concepts?conceptIds=71388002&number=0&size=100' | jq -r '[.items[0].conceptId]'
```

## Get children concept IDs

```bash
curl 'localhost:8080/browser/MAIN/concepts/443859009/children?form=inferred&includeDescendantCount=false' | jq -r '.[].conceptId' > ~/out.txt
```

# Find number objects with property

```bash
cat icpc2_result.txt|jq 'has("conceptId")'
```

# Get objects with a property that has values (example array here)

```bash
cat icpc2_result_01112021.txt|jq '.acceptableNorwegianSynonyms | select(type == "array" and length >= 1)'|wc -l
```
