#!/bin/bash
sleep 1 # Wait until Bluetooth services are fully initialized
wminput -d -c  /home/pi/wiimote 00:1C:BE:F0:3B:61
