
#!/bin/bash

# Disk Monitoring Script
# Project 2 - Linux Administration Toolkit

THRESHOLD=80
CRITICAL=90
LOG_FILE="/var/log/disk_monitor.log"

# Read disk usage, or use a test value
DISK_USAGE="${1:-$(df -P / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')}"

# Validate the disk usage value
if ! [[ "$DISK_USAGE" =~ ^[0-9]+$ ]] || (( 10#$DISK_USAGE > 100 )); then
    echo "ERROR: Disk usage must be a number between 0 and 100."
    exit 2
fi

# Remove leading zeros safely
DISK_USAGE=$((10#$DISK_USAGE))

DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "================================"
echo "       DISK MONITOR REPORT"
echo "================================"
echo "Date: $DATE"
echo "Hostname: $(hostname)"
echo "Disk usage: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge "$CRITICAL" ]; then
    STATUS="CRITICAL"
    EXIT_CODE=2
elif [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    STATUS="WARNING"
    EXIT_CODE=1
else
    STATUS="OK"
    EXIT_CODE=0
fi

echo "Status: $STATUS"

echo "$DATE | $(hostname) | Disk: ${DISK_USAGE}% | $STATUS" >> "$LOG_FILE" || exit 3

exit "$EXIT_CODE"
