#!/bin/bash

echo "==== SERVER HEALTH === $(date)"

echo "USER: $(whoami)"
echo "hostname: $(hostname)"

if [ -f "/var/log" ]; then
    echo "✓ Log directory exists"
else
    echo "✗ Log directory MISSING"
fi

if [ -f "/etc/passwd" ]; then
    echo "✓ password file exists"
    echo "$(wc -l /etc/passwd) users"
else
    echo "✗ password file MISSING"
fi

echo $(tail -n 3 /etc/hosts)

echo $(ls /etc | wc -l)

echo === END OF REPORT ===