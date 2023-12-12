
movie_files=$(find /mnt/mediadrv/Movies -maxdepth 1 -type f ! -name "*.md")
tv_files=$(find /mnt/mediadrv/TV -maxdepth 1 -type f ! -name "*.md")

function move_files {
	for file_name in $1
	do
		folder_name=${file_name%.*}
		echo "making $folder_name"
		mkdir -p "$folder_name"
		echo "moving $file_name into $folder_name"	
		mv "$file_name" "$folder_name"
	done
}

move_files "$movie_files"
move_files "$tv_files"

