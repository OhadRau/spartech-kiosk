#!/usr/bin/env bash

# Check for super user
if [ "$EUID" -ne 0 ]; then
  echo 'Error: This script requires superuser. The program will not be installed. Please try again using sudo.'
  exit
fi

# Populate system directories
cp ./main.native /usr/local/bin/kiosk

mkdir /etc/kiosk/
cp ./config.json /etc/kiosk/config.json

mkdir /var/kiosk/
cp ./data/tickets.db /var/kiosk/tickets.db
cp ./static /var/kiosk/static

# TODO: Add to init system
