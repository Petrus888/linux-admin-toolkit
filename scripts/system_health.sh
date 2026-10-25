#!/bin/bash

echo "===== Linux System Health Report ====="
echo "Hostname: $(hostname)"
echo "Date: $(date)"

echo "===== System Uptime ====="
uptime

echo "===== Memory Usage ====="
free -h

echo "===== Disk Usage ====="
df -h /

echo "===== Nginx Status ====="
systemctl is-active nginx
