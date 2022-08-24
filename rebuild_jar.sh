#!/usr/bin/env bash
# Use case: Used for rebuilding and redeploying smaller code changes on machines. 
#           Assumes you have the app run as a service.
# Example:
# ./rebuild_jar.sh "/opt/snowstorm/" "/opt/snowstorm/snowstorm-dev-build/" "snowstorm.service"

APP_DIR="$1"
BUILD_DIR="$2"
SERVICE="$3"
cd  "$BUILD_DIR"
mvn clean package #-DskipTests=true
JAR="basename $(find target/ -name \*.jar)"
mv "$JAR" .
ln -sf "$JAR" "$APP_DIR""$SERVICE" # We store multiple jars
sudo systemctl restart "$SERVICE"