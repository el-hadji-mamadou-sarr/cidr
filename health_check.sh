#!/bin/bash

echo "========== SERVER HEALTH ========== $(date)"

echo "USER: $(whoami)"
echo "hostname: $(hostname)"

if [ -f "/var/log" ]; then
    echo "✓ Log directory exists"
else
    echo "✗ Log directory MISSING"
    exit 1

if [ -f "/etc/passwd" ]; then
    echo "✓ password file exists"
else
    echo "✗ password file MISSING"
    exit 1



