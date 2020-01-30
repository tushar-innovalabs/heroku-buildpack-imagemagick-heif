#!/bin/bash

# set -x
set -e

docker build --cache-from=imagemagick-heif-heroku16 -t imagemagick-heif-heroku16 .
# docker build --no-cache -t imagemagick-heif-heroku18 .
mkdir -p build

docker run --rm -t -v $PWD/build:/data imagemagick-heif-heroku16 sh -c 'cp -f /usr/src/imagemagick/build/*.tar.gz /data/'
