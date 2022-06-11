#! /usr/bin/env bash

SERIAL='200025CD'

function finish {
  blink1-tool --id $SERIAL --clearpattern -q 1>/dev/null 2>&1
  blink1-tool --id $SERIAL --rgb=000040 --blink 10 -m 500 -t 500 -q 1>/dev/null 2>&1 &
  exit
}
trap finish INT EXIT

blink1-tool --id $SERIAL --clearpattern -q 1>/dev/null 2>&1

function sanity_check {
  blink1-tool --id $SERIAL -q 1>/dev/null 2>&1
  if [[ $? -ne 0 ]]; then exit 1; fi
}

while true; do
  sanity_check
  system_state=`systemctl status | head -n 2 | tail -n 1 | sed 's/.*State:\s\+//g'`
  case $system_state in
    'running')
      blink1-tool --id $SERIAL --rgb=002000 --blink 2 -m 500 -t 500 -q 1>/dev/null 2>&1
      blink1-tool --id $SERIAL --rgb=000100 -g -q 1>/dev/null 2>&1
      sleep 1800;
      ;;
    'starting')
      blink1-tool --id $SERIAL --rgb=003000 --blink 1 -m 500 -t 500 -q 1>/dev/null 2>&1
      ;;
    'degraded')
      blink1-tool --id $SERIAL --rgb=400000 --blink 1 -m 500 -t 500 -q 1>/dev/null 2>&1
      ;;
    *)
      echo $system_state
      blink1-tool --id $SERIAL --rgb=400040 --blink 1 -m 500 -t 500 -q 1>/dev/null 2>&1
      ;;
  esac
done

