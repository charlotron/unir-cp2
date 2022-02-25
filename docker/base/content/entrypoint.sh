#!/bin/bash

echo "Starting ssh server service"
service ssh start

echo "Waiting for new connections"
while :;do
 sleep 300
done