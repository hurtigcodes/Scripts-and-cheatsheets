# Elastic

## Change passwords - auto/interactive

```bash
sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords interactive
```

## Check health

```bash
curl --user [user]:[password] -X GET "localhost:9200/\_cluster/health?wait_for_status=yellow&timeout=50s&pretty"
```

## Get metadata

```bash
curl --user [user]:[password] -X GET "localhost:9200"
```

## Get code system

```bash
curl --user [user]:[password] -X GET "localhost:9200/codesystems/\_search?pretty" -H 'Content-Type: application/json' -d'{ "query": { "term": { "path": "MAIN/SNOMEDCT-NO/SLVMAPS/VSOPOST" } }, "size": 1, "sort": [{ "head": { "order": "desc" } }] }'
curl --user [user]:[password] -X GET "localhost:9200/codesystems/\_search?pretty" -H 'Content-Type: application/json'
```

## Get concepts

```bash
curl --user [user]:[password] -X GET "localhost:9200/concept/\_search?pretty" -H 'Content-Type: application/json' -d'{ "query": { "term": { "path": "MAIN/SNOMEDCT-NO/REFSETS" } }, "size": 10}'
curl --user [user]:[password] -X GET "localhost:9200/concept/\_search?pretty" -H 'Content-Type: application/json' -d'{ "query": { "description": { "conceptId" : "[id]" } }, "size": 10}'
curl -X POST "localhost:9200/concept/\_delete_by_query" -H 'Content-Type: application/json' -d'{ "query": { "term": { "conceptId" : "[id]" } }}'
curl --user [user]:[password] -X GET "localhost:9200/branch-review/" -H 'Content-Type: application/json'
```

## If branch is deleted: To find the latest version of your branch, query Elasticsearch:

```bash
curl --user [user]:[password] -XGET "http://localhost:9200/branch/\_search?pretty" -H 'Content-Type: application/json' -d'{ "query": { "term": { "path": "MAIN/SNOMEDCT-NO" } }, "size": 1, "sort": [{ "head": { "order": "desc" } }] }'
```

## In the response, under hits > hits you should find the \_id field. Take this id and use in the next query (replacing YOUR_ID_HERE) to clear the end date from that version of the branch:

```bash
curl --user [user]:[password] -XPOST "http://localhost:9200/branch/\_update_by_query" -H 'Content-Type: application/json' -d'{ "query": { "term" : { "\_id": "[id]" } }, "script": { "source": "ctx.\_source.remove(\"end\")" }}'
```
