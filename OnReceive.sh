#!/bin/bash
from=$SMS_1_NUMBER
message="$SMS_1_TEXT"

#
if [ "$message" = "ROZBRAJAM" ];
then
  echo "Dostalem ROZBRAJAM, rozbrajam alarm..." | /usr/bin/logger
  /bin/date 1> /var/lib/alarm/rozbrojony 2> /dev/null
else
   echo "Dostalem COKOLWIEK, uzbrajam alarm..." | /usr/bin/logger
  /bin/rm -f /var/lib/alarm/rozbrojony 1> /dev/null 2> /dev/null
fi

#
if [ -f /var/lib/alarm/rozbrojony ];
then
  echo "Wysylam SMS: ROZBROJONY..." | /usr/bin/logger
  /usr/bin/gammu-smsd-inject TEXT $from -text Rozbrojony" | /usr/bin/logger
else
  echo "Wysylam SMS: UZBBROJONY..." | /usr/bin/logger
  /usr/bin/gammu-smsd-inject TEXT $from -text Uzbrojony" | /usr/bin/logger
fi
