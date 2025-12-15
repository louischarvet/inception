#!/bin/bash

if [ -f /initdb_script.sh ]; then
    /initdb_script.sh
    rm /initdb_script.sh
fi

exec mariadbd