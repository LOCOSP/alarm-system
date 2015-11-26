#!/bin/bash

NUMBER=${NUMBER:-601601601}
MESSAGE=${MESSAGE:-Wykryto ruch}

echo ${*} | /usr/bin/logger

if [ ! -f "/tmp/disarmed" ];
then
  /usr/bin/gammu-smsd-inject \
    TEXT ${NUMBER} -text "${MESSAGE}. $(uptime)" \
    | /usr/bin/logger
fi