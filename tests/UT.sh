#!/bin/bash

counter=0
max_attempts=30
until $(curl --output /dev/null --silent --head --fail $1:$2); do
    if (${counter} -eq ${max_attempts}); then
        echo "To many try, Uint Test failed"
        exit 1
    fi
    counter=$(($counter+1))
    sleep 2
done
echo "Ready!"