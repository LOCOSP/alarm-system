#!/bin/bash
from=$SMS_1_NUMBER
message="$SMS_1_TEXT"

#
if [ "$message" = "Disarm" ];
then
  echo "Dostalem Disarm - rozbrajam alarm..." | /usr/bin/logger
  /bin/date 1> /tmp/disarmed 2> /dev/null
elif [ "$message" = "Arm" ];
then
  echo "Dostalem Arm - uzbrajam alarm..." | /usr/bin/logger
  /bin/rm -f /tmp/disarmed 1> /dev/null 2> /dev/null
elif [ "$message" = "Ping" ];
then
  echo "Dostalem Ping - odpowiadam Pong..." | /usr/bin/logger
  /usr/bin/gammu-smsd-inject \
    TEXT $from -text "Pong: $(uptime)" \
    | /usr/bin/logger
else
   echo "Dostalem nieznane polecenie - olewam..." | /usr/bin/logger
fi

# Sprawdzam, czy wiadomosc to Arm lub Disarm...
if echo "$message" | grep -Eq "^(Arm|Disarm)$";
then
  # Sprawdzam, czy istnieje plik /tmp/disarmed...
  if [ -f /tmp/disarmed ];
  then
    echo "Wysylam SMS: ROZBROJONY..." | /usr/bin/logger
    /usr/bin/gammu-smsd-inject \
      TEXT $from -text "Alarm rozbrojony: $(uptime)" \
      | /usr/bin/logger
  else
    echo "Wysylam SMS: UZBBROJONY..." | /usr/bin/logger
    /usr/bin/gammu-smsd-inject \
      TEXT $from -text "Alarm uzbrojony:  $(uptime)" \
      | /usr/bin/logger
  fi
fi
