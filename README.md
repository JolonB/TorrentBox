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

If you want to be able to have the full qBittorrent experience, you can also install it alongside/instead of `qbittorrent-nox` with:

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

You need to give the appropriate permissions to qBittorrent:

```shell
sudo useradd -r -m qbittorrent  # create a user called qbittorrent
sudo usermod -a -G qbittorrent pi  # add the user pi to the qbittorrent user group
```

Finally, copy the `qbittorrent.service` file to `/etc/systemd/system/`:

```shell
sudo cp qbittorrent.service /etc/systemd/system/qbittorrent.service
```

and set it up to run on boot:

```shell
sudo systemctl enable qbittorrent
```

<!--More importantly, we can run it simply with a torrent file or magnet url.
Hopefully I remember to write more about that later. -->

## Install Plex

Plex must first be added to your repositories:

```shell
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo apt update
```

Then you can install Plex with:

```shell
sudo apt install plexmediaserver
```

## Cron Jobs

There are a few scripts for being used in cron jobs (or being run manually).
These are:

* `clean_junk.py` - Cleans out any junk files (.txt, .nfo, etc.) included with the torrents.
* `remove_empty.sh` - Remove empty directories to tidy up the filesystem.
* `move_to_folders.sh` - Move files in the root media directories to a folder with a matching name.

You can add the following to your crontab (`crontab -e`):

```
# Clean up files at night (3am, staggered by 5 minutes)
0 3 * * * $HOME/TorrentBox/clean_junk.py
5 3 * * * $HOME/TorrentBox/remove_empty.sh
10 3 * * * $HOME/TorrentBox/move_to_folders.sh
```

## Create Filesystem

<!-- TODO add the set_up_drives.sh script -->
