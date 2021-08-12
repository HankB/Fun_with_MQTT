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

## Requiremnents

Configure and run a local MQTT broker (`mosquitto`.) On Debian

```text
sudo apt install mosquitto
```

and it is up and running.

Test

```text
hbarta@olive:~/Programming/Fun_with_MQTT$ mosquitto_pub -t TEST -h localhost -m "i'm here"
```

```text
hbarta@olive:~$ mosquitto_sub -t \# -v
TEST i'm here
```

## try a will

```text
mosquitto_pub -t TEST -m "i'm here" -h localhost  --will-payload "I'm now gone" --will-topic "test/will"
```

Does nothing because the publisher has closed the connection gracefully.

This works when interrupted by `<ctrl>C`.

```text
while(:); do echo "I'm still here"; sleep 5; done \
|mosquitto_pub -t TEST -h localhost  --will-payload "I'm now gone" --will-topic "test/will" -l
```

One strategy to use is to have a process that starts at boot, connects to the broker and then just sits there. Alternatively it could send a periodic informational message. The following works when run fdrom a terminal. Will it work when run from cron?

```text
while(:); do echo "I'm still here"; read; done |mosquitto_pub -t TEST -h localhost  --will-payload "I'm now gone" --will-topic "test/will" -l
```

### background and cron

`repeat.sh` runs in the background and from cron. When the `repeat.sh` process is killed, no more updates are sent and no will is seen. If `mosquitto_pub` is killed, the will message is seen.

`read.sh` reports an error and continues when run from a script in the foreground when `read` is used to hang. From a suggestion at <https://stackoverflow.com/questions/2935183/bash-infinite-sleep-infinite-blocking> replacing it with `while true; do sleep 86400; done` works w/out excessive CPU usage.

## TODO

Test client (publisher) on a host other than `localhost` and 

* test with cable disconnect (and subsequent reconnect)
* Test when host performs an orderly shutdown
* test with a client process run from Systemd.
