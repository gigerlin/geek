#!/bin/sh
echo $0 processing $1.$2 $3
# cp is ffmpeg
cp "videos/$1.$2" "www/tmp-$3/$1.mp4"
sed "s/movie/$1/" player.html > www/tmp-$3/player.html
cd www/tmp-$3
zip "$1.zip" *.mp4 player.html
