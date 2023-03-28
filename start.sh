#!/bin/bash

function handler() {
    echo "["$(date "+%Y/%m/%d-%H:%M:%S")"]" SIGTERM ACCEPTED
    exit 0
}

trap 'handler' TERM

while :; do
    sleep 3
done
