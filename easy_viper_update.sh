#!/bin/bash          
# Varible Setup:
source variables.txt

# Run Viper To Update Data
docker run -it --env VI_Plus_API_Key="$VI_Plus_API_Key" --env Updated_Since="$Updated_Since" --env API="$API" --mount type=bind,source="$(pwd)"/data,target=/data kennasecurity/viper

# Upload Data To Index:
elasticsearch_loader --index vi --timeout 30 --progress  --delete json data/*.json --lines
