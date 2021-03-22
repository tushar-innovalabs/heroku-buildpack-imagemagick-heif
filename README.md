heroku-buildpack-imagemagick-heif
=================================

The rise in popularity and use of HEIF/HEIC(High Efficency Image Format) means your project's image processing also needs to be able to handle this format. The current default version of imagemagick installed on heroku:16 dynos is 6.8.9.9 and does not support processing heic image files. This [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) vendors a version of ImageMagick with HEIF support binaries into your project. It is based on several resources including https://github.com/retailzipline/heroku-buildpack-imagemagick-heif.

The orginal buildpack was created for `heroku-18` stacks but this one was modified to work with [Heroku stack:](https://devcenter.heroku.com/articles/stack) `heroku-16`. 

The tar file in the [/build folder](./build) currently contains: 

Version: ImageMagick 7.0.9-22 Q16 x86_64 2020-02-10 https://imagemagick.org

You will need to build a new binary if you want to use a newer or different version. To build a new binary see [How to Build a New Binary](#how-to-build-a-new-binary)

## Usage

**NOTE:** _To ensure the newer version of imagemagick is found in the $PATH and installed first make sure this buildpack is added to the top of the buildpack list or at "index 1"._


From your projects "Settings" tab add this buildpack to your app in the 1st position:

```
https://github.com/HiMamaInc/heroku-buildpack-imagemagick-heif
```

**OR**

From the command line:

```
heroku buildpacks:add https://github.com/HiMamaInc/heroku-buildpack-imagemagick-heif --index 1 --app HEROKU_APP_NAME
```

## How to Build a New Binary

The binaries in this repo were built with Heroku Docker images running in a local dev environment. The tar file was then copied into the `/build` directory in this repo and is used by the [compile script](./bin/compile).

Prerequisites

- Docker installed and running in local dev environment. [Get Docker](https://docs.docker.com/get-docker/)

## Building the binaries

Run `make build` to build all the binaries or you can build for a specific Heroku stack with `make build-heroku-<stack-number>`. Currently only Stack 16 and 20 are supported.


The binary files will be updated in the `/build` folder. Commit and push to the repo.


### Clear cache(_Not Sure if this is necessary)
Since the installation is cached you might want to clean it out due to config changes.

1. `heroku plugins:install heroku-repo`
2. `heroku repo:purge_cache -app HEROKU_APP_NAME`

### Credits
https://medium.com/@eplt/5-minutes-to-install-imagemagick-with-heic-support-on-ubuntu-18-04-digitalocean-fe2d09dcef1
https://github.com/brandoncc/heroku-buildpack-vips
https://github.com/steeple-dev/heroku-buildpack-imagemagick
https://github.com/retailzipline/heroku-buildpack-imagemagick-heif
