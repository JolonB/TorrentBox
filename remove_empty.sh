DIR=/mnt/mediadrv
find $DIR/{TV,Movies} -type d -empty -delete
find $DIR/{TV,Movies} -type f \( -name "*.nfo" -o -name "*.exe" \) #-delete
