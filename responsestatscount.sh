#!/bin/bash

# Created By  : Jose Enrique Valecia
# Version     : 1.0
# Created On  : 16-May-2020
# Updated On  : 16-May-2020
# ScriptName  : responsestatscount.sh
# Description : Counts the number of HTTP 4xx and 5xx response statuses in the apache log file

################################################################################################################
##### Validate Usage
################################################################################################################
if [ $# -ne 1 ]
then
  echo ""
  echo "************************************************************************************************************"
  echo "Usage: ./responsestatscount.sh <apachelogfile>"
  echo "************************************************************************************************************"
  echo ""
  exit 0
fi


################################################################################################################
##### Variables
################################################################################################################

LOGFILE=$1
STATUS403=`cat ${LOGFILE}| awk ' { print $9 } ' | grep 403 | wc -l`
STATUS404=`cat ${LOGFILE}| awk ' { print $9 } ' | grep 404 | wc -l`
STATUS416=`cat ${LOGFILE}| awk ' { print $9 } ' | grep 416 | wc -l`
STATUS500=`cat ${LOGFILE}| awk ' { print $9 } ' | grep 500 | wc -l`
CUMULATIVE_TOTAL=$(($STATUS403+$STATUS404+$STATUS416+$STATUS500))


################################################################################################################
##### Main Script
################################################################################################################

if [ $CUMULATIVE_TOTAL -gt 100 ]; then
   echo "The total count of HTTP 4xx and 5xx response statuses is ${CUMULATIVE_TOTAL}." >> emailbody.txt
   echo "Below is the breakdown:" >> emailbody.txt
   echo "" >> emailbody.txt
   echo "Count Status" >> emailbody.txt
   cat  ${LOGFILE} | awk '{ print $9 }' | grep 403 | uniq -c >> emailbody.txt
   cat  ${LOGFILE} | awk '{ print $9 }' | grep 404 | uniq -c >> emailbody.txt
   cat  ${LOGFILE} | awk '{ print $9 }' | grep 416 | uniq -c >> emailbody.txt
   cat  ${LOGFILE} | awk '{ print $9 }' | grep 500 | uniq -c >> emailbody.txt
   
   cat emailbody.txt | mail -s "HTTP Status Code Alert" mahikero@yahoo.copm.com
fi

rm emailbody.txt

################################################################################################################
##### End of Script
################################################################################################################