#!/bin/bash

echo "starting deployment ..."

APP_NAME="myapp"
VERSION="1.0.0"

echo "Deploing $APP_NAME version $VERSION"

if [ -f "/var/app/config.yml" ];then
    echo "Config file found!"
else
    echo "ERROR: Config file missing!"
    exit 1
fi

echo "Done!"