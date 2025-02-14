#!/bin/bash

# Replace 'eth0' with your network interface name
INTERFACE="eth0"

# Bring the interface down
ip link set $INTERFACE down

# Change the MAC address
macchanger -r $INTERFACE

# Bring the interface back up
ip link set $INTERFACE up
