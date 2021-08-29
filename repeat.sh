#!/bin/sh

set -e # exit on error

# connect and send startup message followed by periodic messages

host=$(hostname)

(
    echo "$host connecting"; \
    while(:)
    do
        sleep 5
        echo "$host still here"
    done 
) | \
mosquitto_pub  -t TEST \
               -h localhost \
               --will-payload "$host now gone" \
               --will-topic "TEST/will" -l