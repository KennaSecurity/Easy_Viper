#!/bin/bash

#Import Varibles
source variables.txt

op=$(echo "$1" |  tr '[:lower:]' '[:upper:]')

case $op in

  BUILD)
    echo "Building ..."
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

    echo "Completed, this Kibana console should now be available here: http://localhost:5601/"
    ;;

  DELETE)
      # Down with Extreme Predjudice
      docker-compose down -v
      echo "Delete Completed"
      ;;

  DOWN)
      # Down
      docker-compose down
      echo "Appropriate Containers are Down"
      ;;

  UP)
      docker-compose up -d

      # Run Viper To Update Data
      docker run -it --env VI_Plus_API_Key="$VI_Plus_API_Key" --env Updated_Since="$Updated_Since" --env API="$API" --mount type=bind,source="$(pwd)"/data,target=/data kennasecurity/viper

      # Upload Data To Index:
      elasticsearch_loader --index vi --timeout 30 --progress  --delete json data/*.json --lines

      echo "Appropriate Containers are up and available here: http://localhost:5601/"
      ;;

  UPDATE)
    # Run Viper To Update Data
    docker run -it --env VI_Plus_API_Key="$VI_Plus_API_Key" --env Updated_Since="$Updated_Since" --env API="$API" --mount type=bind,source="$(pwd)"/data,target=/data kennasecurity/viper

    # Upload Data To Index:
    elasticsearch_loader --index vi --timeout 30 --progress  --delete json data/*.json --lines

    read "Shall we update the variables.txt file with "
    echo "Data Updated, appropriate Containers are up and available here: http://localhost:5601/"
    ;;

  *)
    echo "Easy Viper Script"
    echo "Easy Viper allows you to build a local Elastic Stack"
    echo "quickly using docker-compose and import data directly from the Kenna VI+ API using Viper."
    echo .
    echo "  BUILD: Download, and Launch Containers, then pull information from the Kenna VI+ API. (This is the first thing to run)."
    echo "  UPDATE: Pull new data based from Kenna VI+ API."
    echo "  DOWN: Shutdown Easy Viper Containers"
    echo "  UP: Launch Previously Built Easy Viper Containers"
    echo "  DELETE: Shutdown and Delete Easy Viper Containers"
    ;;

esac
