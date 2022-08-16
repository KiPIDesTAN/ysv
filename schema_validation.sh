#!/bin/bash

##################################################
#
# This script will find all the yaml files in the provided directory,
# download the schema for the yaml file, if found, and validate
# the schema.
#
##################################################

DIR=$1  # directory to look for the yaml files in
TEMP=$2

URL_REGEX='https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)'

for YML_FILE in $DIR/*.yml
do
    echo "Processing $YML_FILE"
    JSON_FILE="$(basename -s .yml $YML_FILE).json"
    yq -o json $YML_FILE > $TEMP/$JSON_FILE
    SCHEMA_URL=$(jq -r '."$schema"' $TEMP/$JSON_FILE)
    if [[ "$SCHEMA_URL" =~ $URL_REGEX ]]; then
        SCHEMA_FILENAME=$(basename $SCHEMA_URL)

        echo "Downloading schema file."
        curl --output $TEMP/$SCHEMA_FILENAME --tlsv1.2 -s $SCHEMA_URL

        echo "Validating yaml file against schema."
        jsonschema -i $TEMP/$JSON_FILE $TEMP/$SCHEMA_FILENAME

        VALIDATION_RESULT=$?
        if [ $VALIDATION_RESULT -ne 0 ]; then
            exit $VALIDATION_RESULT
        else
            echo "Validation passed."
        fi
    else
        echo "Skipping $YML_FILE. No \$schema key found in file."
    fi

done