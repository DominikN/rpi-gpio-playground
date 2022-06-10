# rpi-gpio-playground

Testing serial port and GPIO on Raspberry Pi in Python using Docker.

```
docker run --rm -it --privileged python:3.10 bash
```

```
docker compose up
```

## BASH

### `gpiod`

More info [here](https://waldorf.waveform.org.uk/2021/the-pins-they-are-a-changin.html).

```bash
sudo apt install gpiod

# set GPIO13 (pin33) high
sudo gpioset -m wait 0 13=1 
```

It looks like in ubuntu 20.04 the pin state should persist - [source](https://raspberrypi.stackexchange.com/questions/136479/confusion-with-libgpiod-and-the-gpiod-user-tools)