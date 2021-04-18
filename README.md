# Secure and lightweight CUPS image
## Motivation

The existing Docker images for Cups on ARMv8 don't really respect security and/or lightweightness. So I've decided to make my own image which aims to be more secure while being less bloated.

## Usage/Configuration

Apply configuration changes to `cupsd.conf` before building, if needed.

There is only one extra environment variable:

`CUPS_PASS` - if this environment variable is set in the container, the admin password of user `print` will be updated for this container. Changes are not persistent for the image.

**Note**: Upon starting the container it will generate a new random password for the `print` user. If you dont wish this behaviour, set the `CUPS_PASS` variable. 


As for ports: TCP 631 is the standard cups port for printing and the web interface. (see configuration)

If you wish to disable Avahi advertisement, remove the exposed UDP port 5353.

## Build & Run

```sh
sudo docker build -t rpi-cups-secure:latest .
sudo docker run -d -p 631:631 -p 5353:5353/udp --device /dev/bus/usb --name cups rpi-cups-secure:latest
``` 

You'll see the login password for user `print` in the beginning of the log output.   
The USB-device is needed if you have an USB printer. These options don't need the dbus connection or running the container with the `--privileged` flag, as many other releases do.
