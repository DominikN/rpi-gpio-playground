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
# enable_uart=1 # comment to use uart0 as primary

# Disable Bluetooth
dtoverlay=disable-bt
```

Disable Bluetooth service:

### Bash

```bash
sudo systemctl disable hciuart.service
sudo systemctl disable bluetooth.service

systemctl disable serial-getty@ttyS0.service
systemctl stop serial-getty@ttyS0.service
systemctl mask serial-getty@ttyS0.service
```

```bash
sudo reboot
```

## Random notes

Working configuration for enabled UART 4 (`GPIO8` is TXD ; `GPIO9` is RXD):

`/boot/firmware/config.txt`

```bash
[all]
kernel=vmlinuz
cmdline=cmdline.txt
initramfs initrd.img followkernel

[pi4]
max_framebuffers=2
arm_boost=1

[all]
# Enable the audio output, I2C and SPI interfaces on the GPIO header. As these
# parameters related to the base device-tree they must appear *before* any
# other dtoverlay= specification
dtparam=audio=on
dtparam=i2c_arm=on
dtparam=spi=on

# Comment out the following line if the edges of the desktop appear outside
# the edges of your display
disable_overscan=1

# If you have issues with audio, you may try uncommenting the following line
# which forces the HDMI output into HDMI mode instead of DVI (which doesn't
# support audio output)
#hdmi_drive=2

# Enable the serial pins
enable_uart=1

# Autoload overlays for any recognized cameras or displays that are attached
# to the CSI/DSI ports. Please note this is for libcamera support, *not* for
# the legacy camera stack
camera_auto_detect=1
display_auto_detect=1

# Config settings specific to arm64
arm_64bit=1
dtoverlay=dwc2

[cm4]
# Enable the USB2 outputs on the IO board (assuming your CM4 is plugged into
# such a board)
dtoverlay=dwc2,dr_mode=host

[all]
# Disable Bluetooth
dtoverlay=disable-bt
dtoverlay=uart4
```

UART4 is listing under `/dev/ttyAMA1` now:

```bash
$ ls -la /dev/ttyAMA*
crw--w---- 1 root tty     204, 64 Jun 13 17:27 /dev/ttyAMA0
crw-rw---- 1 root dialout 204, 65 Jun 13 17:27 /dev/ttyAMA1
```

```
        TXD RXD CTS RTS     Board Pins
uart0   14  15              8   10
uart1   14  15              8   10
uart2   0   1   2   3       27  28  (I2C)
uart3   4   5   6   7       7   29
uart4   8   9   10  11      24  21  (SPI0)
uart5   12  13  14  15      32  33  (gpio-fan)
```