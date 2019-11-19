#!/bin/bash

# Script to record the last moment when noip2 service has update the ddns address in this device.

#INFO=`sudo /usr/local/bin/noip2 -S`
DATE=`date`
PATHY="/tmp/noip.log"

echo -e "noip2 successfully updated the host name at: \n $DATE " > $PATHY
#echo "`sudo /usr/local/bin/noip2 -S >> $PATHY`"
exit
