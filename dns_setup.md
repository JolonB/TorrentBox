# DNS Server Setup

If you want a nice way to connect to everything, you can set up a DNS server on this Pi.

To do this, we start by installing `dnsmasq` with:

```shell
sudo apt install dnsmasq
```

`dnsmasq` gets the hostnames from the `/etc/hosts` file.
You need to edit this file to include the IP address of the Pi (and anything else you're interested in) and its alias.

To begin, you need to first get the IP address of the Pi.
You can find this with the `ip addr` command.
If you are working with a wireless network (not recommended), the IP address will be under `wlan0`.
If you have a wired connection, the IP address will probably be under `eth0`.

Once you have the IP address (of the form `192.168.x.x`; do not include the `/24` at the end), you can edit the `/etc/hosts` file (with sudo) to include:

```text
# IP Address	Host Name
192.168.x.x	torrents
```

The IP address should match the one you found from `ip addr` and the host name can be whatever you want it to be.

If the DNS server isn't already running, you can start it with:

```shell
sudo dnsmasq
```

Or restart it with:

```shell
sudo service dnsmasq restart
```


