#!/usr/bin/bash

echo " Server Performance Stats"
echo "======================"

# Total CPU Usage
echo ""
echo ">> Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{printf "Used: %.1f%%, Idle: %.1f%%\n", 100 - $8, $8}'

# Total Memory Usage
echo ""
echo ">> Memory Usage:"
free -m | awk 'NR==2 {
    total=$2; used=$3; free=$4;
    printf "Total: %d MB, Used: %d MB, Free: %d MB (Used: %.1f%%)\n", 
    total, used, free, used/total*100
}'

# Total Disk Usage
echo ""
echo ">> Disk Usage (root partition):"
df -h / | awk 'NR==2 {
    printf "Total: %s, Used: %s, Available: %s (Used: %s)\n", $2, $3, $4, $5
}'

# Top 5 processes by CPU usage
echo ""
echo ">> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo ""
echo ">> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6



