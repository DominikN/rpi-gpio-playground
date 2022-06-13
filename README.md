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



## Enable UART on Raspbery Pi 4 (Ubuntu 22.04)

> Info:
> All configuration options are listed here:
> `/boot/firmware/overlays/README`

### Make backup

```
sudo su
cd /boot/firmware/
cp cmdline.txt backup-cmdline.txt
cp config.txt backup-config.txt
```

### `config.txt`

Add lines:

```bash
# Enable the serial pins
enable_uart=1
dtoverlay=uart0,txd0_pin=14,rxd0_pin=15

# Disable Bluetooth
dtoverlay=disable-bt
```

Disable Bluetooth service:

### Bash

```bash
sudo systemctl disable hciuart
sudo systemctl mask hciuart
```

```bash
sudo reboot
```