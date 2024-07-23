#!/bin/bash
MAC='AC:12:2F:D4:C1:0C'
CONNECTED=$(hcitool con)

if [[ "$CONNECTED" =~ "$MAC" ]];
then
  bluetoothctl disconnect $MAC
else
  bluetoothctl connect $MAC
fi

