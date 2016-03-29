#!/bin/sh
echo $0 processing $1.$2 $3
# cp is ffmpeg
cp -r player www/tmp-$3/.
mkdir www/tmp-$3/data
mv "videos/$1.$2" "www/tmp-$3/data/clip.mp4"
# sed "s/clip/$1/" player.html > www/tmp-$3/index.html
cp player.html www/tmp-$3/index.html
cd www/tmp-$3
zip -r -m "$1.zip" index.html player/ data/
