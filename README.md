# TorrentBox Setup

## Initial Setup

Before starting, you need to set up a Raspberry following the instructions [here]().

The next step is to update everything with:

```shell
sudo apt update
sudo apt full-upgrade
```

## Install qBittorrent

We only need the headless version of qBittorrent.
This can be installed with:

```shell
sudo apt install qbittorrent-nox
```

If you want to be able to have the full qBittorrent experience, you can also install it alongside `qbittorrent-nox` with:

```shell
sudo apt install qbittorrent
```

You can start qBittorrent by running:

```shell
# Default port (8080)
qbittorrent-nox
# Custom port
qbittorrent-nox --webui-port=<port>
```

More importantly, we can run it simply with a torrent file or magnet url.
Hopefully I remember to write more about that later.

