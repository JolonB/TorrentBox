# TorrentBox Setup

## Requirements

* Raspberry Pi
* SD Card
* USB Storage Medium
* Raspberry Pi power supply and cable
* Ethernet cable (optional)

## Initial Setup

Before starting, you need to set up a Raspberry following the instructions [here](https://projects.raspberrypi.org/en/projects/raspberry-pi-setting-up/0).
If you plan on using Wi-Fi, it is a good idea to set the credentials when flashing the SD card, otherwise you will need to connect it to a keyboard and monitor.

Once it is all set up and you have connected via SSH, the next step is to update everything with:

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

You can view the Web UI by accessing the IP address of the Raspberry Pi followed by the port number (default is 8080) in a web broswer.
For example, `192.168.0.13:8080`.

You can configure qBittorrent to launch on boot by adding the following to your crontab (edit crontab with `crontab -e`):

```
@reboot $HOME/TorrentBox/torrentbox.sh
```

The file `qBittorrent.conf` can be copied to `~/.config/qBittorrent/qBittorrent.conf`.
This contains some configuration settings that may be useful.
More importantly, it sets up the TV and Movies categories and their installation directory.
Without doing this, there would be no reason to set up the external drive.

If you choose to do this in the web UI, simply right click under the "CATEGORIES" header in the sidebar and select "Add category...".
You should create two categories, one called "TV" located at `/mnt/mediadrv/TV`, and one called "Movies" located at `/mnt/mediadrv/Movies`.

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

Add the following line to the end of your `/etc/fstab` file:

```
LABEL=MEDIA /mnt/mediadrv auto defaults,auto,users,rw,nofail,noatime 0 0
```

This simply mounts a drive called MEDIA to `/mnt/mediadrv`.

In order to set up this drive, connect it to the Raspberry Pi or your PC.

### Raspberry Pi

To do this on the Raspberry Pi or another Linux device, first connect it to the computer.
If it auto-mounts, unmount it with `sudo umount /path/to/device`.
Find your device with `lsblk -f`.
Take note of the device name (probably `sd**`).

Next, you can format it to whatever filesystem you prefer, however, some can only be treated as removable drives, and cannot be mounted with the appropriate permissions.
Both NTFS and EXT4 work, but there may be other options.
If your drive is already one of these formats, you don't need to run this command:

```shell
# WARNING: this will delete all files on the drive
# NTFS
sudo mkfs -t ntfs /dev/sd** -Q
# EXT4
sudo mkfs -t ext4 /dev/sd**
```

Next, you need to label the drive so it can be automatically mounted.
The command depends on what you formatted the drive as.

```shell
# NTFS
sudo ntfslabel /dev/sd** MEDIA
# EXT4
sudo e2label /dev/sd** MEDIA
```

You may choose to set the appropriate permissions for the drive.
This can be done by mounting to `/mnt/mediadrv` and running `chmod`:

```shell
sudo mount -a  # This will mount the drive if your fstab is configured
sudo chmod 777 /mnt/mediadrv -R
```

Next, you need to add the drive to your fstab, so it is treated as a permanent drive.
In the `/etc/fstab` file, add the following, replacing `<uuid>` with your UUID:

```
UUID=<uuid> /mnt/mediadrv ntfs defaults,auto,users,rw,nofail,noatime 0 0
```

Once that has been done, you should create the directories for your TV shows and movies:

### Windows

If the filesystem type *isn't* a format compatible with Linux, you should reformat the drive.
I typically reformat to NTFS because it is compatible with Windows too.
Make sure you back up the drive, because any data will be deleted.

Insert the USB drive, right click on it in File Explorer, and select "*Format*".
<!-- TODO finish instructions and add images -->

## Plex

To add the Plex repository in Debian, run the following commands:

```shell
# All commands need sudo. Consider running `sudo -v` before pasting
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
sudo apt update
```

After that, it can be installed with:

```shell
sudo apt install plexmediaserver
```

You can then launch Plex using:

```shell
sudo systemctl start plexmediaserver
```

and access it at `192.168.x.x:32400/web`.

Once you're connected, follow [these instructions](https://support.plex.tv/articles/200288896-basic-setup-wizard/) to get set up.
Make sure you use `/mnt/mediadrv/TV` for the TV show library, and `/mnt/mediadrv/Movies` for the movie library.

