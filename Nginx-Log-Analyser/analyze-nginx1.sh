#!/usr/bin/bash

LOGFILE="$1"
# This stores the first command-line argument (i.e., the log file path) into the variable LOGFILE.

DATE_FILTER="$2"
#This assigns the second argument passed to the script (e.g., "10/Jul/2018") to the variable DATE_FILTER. It's used to filter log entries for a specific date. 

if [[ ! -f "$LOGFILE" ]]; then
  echo "Usage: $0 <logfile> [optional-date-filter]"
  exit 1
fi
#This checks if the file does not exist (! -f) at the path given.
#If it doesn't, the script prints a usage message and exits with status code 1 (error)

if [[ -n "$DATE_FILTER" ]]; then
#This checks if the date filter is not empty. -n means "non-zero length" — it’s true when the user actually passed a second argument.
  grep "$DATE_FILTER" "$LOGFILE" > /tmp/filtered.log
#This uses grep to extract only those lines from the log file that contain the given date (e.g., 10/Jul/2018). The matching lines are written to a temporary file: /tmp/filtered.log.
  LOGFILE="/tmp/filtered.log"
fi

RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'

echo -e "${GREEN}Total Requests:${NC} $(wc -l < "$LOGFILE")"
echo -e "${GREEN}Unique IPs:${NC} $(awk '{print $1}' "$LOGFILE" | sort -u | wc -l)"

echo -e "\n${CYAN}Top 5 IP addresses:${NC}"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5

echo -e "\n${CYAN}Top 5 Requested Paths:${NC}"
awk -F\" '{print $2}' "$LOGFILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5

echo -e "\n${CYAN}Top 5 Status Codes:${NC}"
awk '{print $9}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5

echo -e "\n${CYAN}Top 5 User Agents:${NC}"
awk -F\" '{print $6}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
