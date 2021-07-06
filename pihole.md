# Pi-Hole Setup

To get the required packages for Pi-Hole, simply run:

```shell
curl -sSL https://install.pi-hole.net | sudo bash
```

This should start running a script to install the Pi-Hole software.
In most cases, you probably just need to accept everything (press Enter/Return) unless you know there is a setting you want to change.
If all goes well, the installer should set everything up for you.

## Replacing dnsmasq

The only step you need to do is log in to the admin panel and go to `Local DNS > DNS Records` and add domain names for IP addresses.
If all goes well, you won't need to use `dnsmasq` at all.

