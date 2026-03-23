#!/bin/bash

echo "== NETWORK INSPECTION =="

echo "IP ADDRESS: $(hostname -I)"


if ping -c 3 -q 8.8.8.8 > /dev/null 2>&1; then
    echo "✓ Internet reachable"
else
    echo "✗ No internet"
fi

echo "DNS LOOKUP for github.com"
nslookup github.com | grep "Address" | tail -1
echo ""
 
if ss -tulpn | grep -q ":22 "; then
    echo "Port 22 is onpen"
else
    echo "Port 22 is closed"
fi 

if ss -tulpn | grep -q ":80 "; then
    echo "Port 80 is open"
else
    echo "Port 80 is closed"
fi

echo "Status code on exemple.com: $(curl -s -o /dev/null -w "%{http_code}" https://example.com)"

if sudo ufw status |  grep -q "Status: inactive"; then
    echo "ufw inactive"
else
    echo "ufw active"
fi

echo "== END OF REPORT =="

