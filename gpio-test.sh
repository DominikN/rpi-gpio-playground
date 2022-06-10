#!/bin/bash

export LED=26

echo $LED > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$LED/direction

while true
do
    echo "1" > /sys/class/gpio/gpio$LED/value
    sleep 1
    echo "0" > /sys/class/gpio/gpio$LED/value
    sleep 1
done
