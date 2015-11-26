#!/bin/bash
from=$SMS_1_NUMBER
message="$SMS_1_TEXT"

#
if [ "$message" = "ROZBRAJAM" ];
then
  echo "Dostalem ROZBRAJAM, rozbrajam alarm..." | /usr/bin/logger
  /bin/date 1> /tmp/rozbrojony 2> /dev/null
else
   echo "Dostalem COKOLWIEK, uzbrajam alarm..." | /usr/bin/logger
  /bin/rm -f /tmp/rozbrojony 1> /dev/null 2> /dev/null
fi

#
if [ -f /tmp/rozbrojony ];
then
  echo "Wysylam SMS: ROZBROJONY..." | /usr/bin/logger
  /usr/bin/gammu-smsd-inject TEXT $from -text "Rozbrojony" | /usr/bin/logger
else
  echo "Wysylam SMS: UZBBROJONY..." | /usr/bin/logger
  /usr/bin/gammu-smsd-inject TEXT $from -text "Uzbrojony" | /usr/bin/logger
fi
