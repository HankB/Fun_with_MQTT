# Fun_with_MQTT

Explore MQTT last will and testament

## Motivation

I have several Raspberry Pis that publish information to an MQTT broker. Occasionally these go away for one reason or another. I'd like to know when this happens.

## Possible strategy

The broker is feeding a Homeassistant instance. Perhaps that will be useful for monitoring the messages. The first outline to try is

1. Publish the will on boot, also recording boot events.
1. Publish some sort of updates periodically. Most hosts usually publish on a periodic basis and ideally this could be used as a 'still alive' message.

## Questions

1. Can this be done using `mosquitto_pub` which is normally configured to start, opewn a connection, publish one message and then exit.
2. 
