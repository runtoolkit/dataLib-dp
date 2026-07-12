#!/bin/bash

JSON_FILE="dependencies.json"

if [[ ! -f "$JSON_FILE" ]]; then
    echo "ERROR: $JSON_FILE not found."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "ERROR: jq is required but not installed."
    exit 1
fi

echo "Embedded dependencies:"
jq -r '.embedded[] | "- \(.id) (\(.version))\n  Source: \(.source)\n  License: \(.license)\n  Namespace: \(.namespace)\n  Load tag: \(.load_tag)\n  Note: \(.note)\n"' "$JSON_FILE"

echo "Required dependencies:"
jq -r '.required[] | "- \(.id)\n  Source: \(.source)\n  Note: \(.note)\n"' "$JSON_FILE"