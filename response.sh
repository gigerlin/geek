#!/bin/sh
echo $0 processing $1 $2
mkdir www/tmp-$1
cp process.html www/tmp-$1/
sed "s/random/$2.zip/g" response.html > www/tmp-$1/response.html
