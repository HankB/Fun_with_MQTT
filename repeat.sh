#!/bin/sh

set -e # exit on error

while(:); do echo "I'm still here"; sleep 5; done \
|mosquitto_pub -t TEST -h localhost  --will-payload "I'm now gone" --will-topic "test/will" -l