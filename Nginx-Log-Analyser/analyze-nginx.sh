#!/usr/bin/bash

LOGFILE="nginx-access.log"

echo "Top 5 IP addresses:"
awk '{print $1}' $LOGFILE | sort | uniq -c | sort -nr | head -5

echo -e "\nTop 5 Requested Paths:"
awk -F\" '{print $2}' $LOGFILE | awk '{print $2}' | sort | uniq -c | sort -nr | head -5

echo -e "\nTop 5 Status Codes:"
awk '{print $9}' $LOGFILE | sort | uniq -c | sort -nr | head -5

echo -e "\nTop 5 User Agents:"
awk -F\" '{print $6}' $LOGFILE | sort | uniq -c | sort -nr | head -5
