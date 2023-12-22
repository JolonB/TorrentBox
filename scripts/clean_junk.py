#!/usr/bin/python3
import os
from pathlib import Path

root_dir = "/mnt/mediadrv"
filetypes = ["jpg", "jpeg", "nfo", "txt"]
media_dirs = ["TV", "Movies"]

if __name__ == "__main__":
    os.chdir(root_dir)
    for media_dir in media_dirs:
        for filetype in filetypes:
            for path in Path(media_dir).rglob("*." + filetype):
                print("Removing {}...".format(path))
                os.remove(path)
