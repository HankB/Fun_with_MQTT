#!/bin/sh

set -e # exit on error

# connect and send periodic message to broker

host=$(hostname)

while(:)
do
    echo "$host still here"
    sleep 5
done | \
mosquitto_pub  -t TEST \
               -h localhost \
               --will-payload "$host now gone" \
               --will-topic "TEST/will" -l