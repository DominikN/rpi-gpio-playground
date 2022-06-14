#!/usr/bin/python3

import RPi.GPIO as GPIO
import time

print('start')

led = 12 # GPIO18
GPIO.setmode(GPIO.BOARD)
GPIO.setup(led, GPIO.OUT)

while True:
    GPIO.output(led, GPIO.HIGH)
    time.sleep(0.2)
    GPIO.output(led, GPIO.LOW)
    time.sleep(0.2)
    print('test')

GPIO.cleanup()