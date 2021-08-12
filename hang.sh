#!/bin/sh

while(:); do echo "I'm still here"; while true; do sleep 86400; done; done \
|mosquitto_pub -t TEST -h localhost  --will-payload "I'm now gone" --will-topic "test/will" -l