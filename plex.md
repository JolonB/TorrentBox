# Plex Setup

Begin by installing the necessary prerequisites and adding the Plex repositories to `apt` with:

```shell
sudo apt-get install apt-transport-https
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
sudo apt update
```

Plex can now be installed with:

```shell
sudo apt install plexmediaserver
```

The final step is to connect to it at `192.168.x.x:32400/web` from a PC and set it up there.

