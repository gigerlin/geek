#!/bin/sh
echo processing $1.$2
n=$RANDOM
mkdir tmp-$n
cp "videos/$1.$2" "tmp-$n/$1.mp4"
sed "s/movie/$1/" player.html > tmp-$n/player.html
cd tmp-$n
zip "$1.zip" *
mv *.zip ../www/videos/.
cd ..
rm -rf tmp-$n