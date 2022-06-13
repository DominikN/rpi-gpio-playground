#!/usr/bin/python3

import serial
import time

ser = serial.Serial('/dev/ttyS0', 115200)  # open serial port

while True:
    print(ser.name)         # check which port was really used
    ser.write(b'hello')     # write a string
    # print(ser.read())
    time.sleep(0.5)

ser.close()             # close port