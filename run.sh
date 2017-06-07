#!/bin/bash

set -e
sed -i "s/rlimit-nproc=3/#rlimit-nproc=3/" /etc/avahi/avahi-daemon.conf

sed -i "s/HOME_ASSISTANT_URL/"$(echo $HOME_ASSISTANT_URL | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"/" /root/.homebridge/config.json
sed -i "s/HOME_ASSISTANT_PASSWORD/"$(echo $HOME_ASSISTANT_PASSWORD | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')"/" /root/.homebridge/config.json

rm -f /var/run/dbus/pid

dbus-daemon --system
avahi-daemon -D

homebridge
