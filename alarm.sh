#!/bin/sh

echo alarm | /usr/bin/logger

if [ ! -f "/var/lib/alarm/rozbrojony" ];
then
  echo "WLAMANIE!" |  /usr/bin/gammu-smsd-inject "TEXT PHONE NUMBER"
fi
