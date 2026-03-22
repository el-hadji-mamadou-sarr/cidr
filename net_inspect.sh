#!/bin/bash

echo "== NETWORK INSPECTION =="

echo "IP ADDRESS: $(hostname -I)"


if [[ $(ping -c 3 -q google.com) == *"3 received, 0% packet loss,"* ]]; then
    echo "✓ Internet reachable"
else
    echo "✗ No internet"
fi

echo "DNS LOOKUP"
echo $(nslookup github.com)
 
if [[ $(ss -tulpn | grep 127.0.0.1:22) ]]; then
    echo "Port 22 is onpen on localhost"
else
    echo "Port 22 is closed"
fi 

if [[ $(ss -tulpn | grep 127.0.0.1:80) ]]; then
    echo "Port 80 is open on localhost"
else
    echo "Port 80 is closed"
fi

echo "Status code on exemple.com: $(curl -s -o /dev/null -w "%{http_code}" https://example.com)"

if [[ $(sudo ufw status) == "Status: inactive" ]]; then
    echo "ufw inactive"
else
    echo "ufw active"
fi
echo "== END OF REPORT =="

