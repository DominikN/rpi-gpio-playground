#!/bin/bash

export LED=13 # pin 33

echo $LED > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$LED/direction

while true
do
    echo "1" > /sys/class/gpio/gpio$LED/value
    sleep 1
    echo "0" > /sys/class/gpio/gpio$LED/value
    sleep 1
done

# gpioset --mode=exit pinctrl-bcm2835 26=1