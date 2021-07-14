#!/bin/bash          

#Import Varibles
source variables.txt

# Install Needed Python Library
pip3 install elasticsearch_loader > /dev/null

# Setup ELK Stack
docker-compose up -d

# Run Viper To Download Data
docker run -it --env VI_Plus_API_Key="$VI_Plus_API_Key" --env Updated_Since="$Updated_Since" --env API="$API" --mount type=bind,source="$(pwd)"/data,target=/data kennasecurity/viper

# Setup VI Index
curl -XPUT 'http://:9200/vi?pretty' -H 'Content-Type: application/json' -d'{"settings" : {"index" : {"number_of_shards" : 3, "number_of_replicas" : 0 }}}'

# Upload Data To Index:
elasticsearch_loader --index vi --timeout 30 --progress  --delete json data/*.json --lines

# Create Search Pattern
curl -XPOST "http://localhost:9200/.kibana/_doc/index-pattern:vi*" -H 'Content-Type: application/json' -d'
{
  "type" : "index-pattern",
  "index-pattern" : {
    "title": "vi",
    "timeFieldName": "last_modified"
  }
}'

# Enable Kibana Dark Mode Theme
curl -f -XPOST -H "Content-Type: application/json" -H "kbn-xsrf: kibana" \
    "http://localhost:5601/api/kibana/settings/theme:darkMode" \
    -d '{ "value": true}'