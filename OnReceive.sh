#!/bin/sh
echo OnReceive | /usr/bin/logger
from=$SMS_1_NUMBER
message="$SMS_1_TEXT"
reply=""

#
echo "$from" | /usr/bin/logger
echo "$message" | /usr/bin/logger
echo "$(whoami)" | /usr/bin/logger

#
if /usr/bin/test "$message" = "ROZBRAJAM";
then
  echo "Dostalem ROZBRAJAM, rozbrajam alarm..." | /usr/bin/logger
  /bin/date > /var/lib/alarm/rozbrojony
else
   echo "Dostalem COKOLWIEK, uzbrajam alarm..." | /usr/bin/logger
  /bin/rm -f /var/lib/alarm/rozbrojony
fi

#
if [ -f /var/lib/alarm/rozbrojony ];
then
  echo "Wysylam SMS ROZBROJONY..." | /usr/bin/logger
#  echo "Rozbrojony" | /usr/bin/gammu-smsd-inject TEXT $from
# /usr/bin/gammu-smsd-inject TEXT +48600260624 -text "ALARM ROZBROJONY"
#  echo "ALARM ROZBROJONY" | /usr/bin/gammu sendsms TEXT "$from"
  /var/spool/alarm/rozbrojony.sh
else
  echo "Wysylam SMS UZBBROJONY..." | /usr/bin/logger
#  echo "Uzbrojony" | /usr/bin/gammu-smsd-inject TEXT $from
#  /usr/bin/gammu-smsd-inject TEXT +48600260624 -text "ALARM UZBROJONY"
#  echo "ALARM UZBROJONY" | /usr/bin/gammu sendsms TEXT "$from"
  /var/spool/alarm/uzbrojony.sh
fi

echo "KONCZE" | /usr/bin/logger
exit 0
