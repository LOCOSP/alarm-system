#!/bin/bash
echo alarm | /usr/bin/logger

if [ ! -f "/tmp/Disarmed" ];
then
 /usr/bin/gammu-smsd-inject \
      TEXT PhoneNumberHere -text "!! WLAMANIE !!" \
      | /usr/bin/logger
fi
