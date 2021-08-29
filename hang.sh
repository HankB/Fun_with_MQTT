#!/bin/sh

# This script sends the startup message and then just hangs - e.g. no updates

hostname=$(hostname)

while(:)
    do echo "$hostname connected"
    while true
    do 
        sleep 86400; 
    done; 
done \
|mosquitto_pub  -t TEST \
                -h localhost \
                --will-payload "$hostname now gone" \
                --will-topic "TEST/will" \
                -l