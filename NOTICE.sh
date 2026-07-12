#!/bin/bash

if [[ ! -f NOTICE ]]; then
    echo "ERROR: NOTICE file not found."
    exit 1
fi

exec less NOTICE