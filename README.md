heroku-buildpack-imagemagick-heif
=================================

## Motivation

The rise in popularity and use of HEIF/HEIC(High Efficency Image Format) means your project's image processing also needs to be able to handle this format. The current default version of imagemagick installed on heroku:16 dynos is 6.8.9.9 and does not support processing heic image files. This [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) vendors a version of ImageMagick with HEIF support binaries into your project. It is based on several resources including https://github.com/retailzipline/heroku-buildpack-imagemagick-heif.

The orginal buildpack was created for `heroku-18` stacks but this one was modified to work with [Heroku stack:](https://devcenter.heroku.com/articles/stack) `heroku-16` and `heroku-20`. 

The tar file in the [/build folder](./build) currently contains: 

You will need to build a new binary if you want to use a newer or different version. To build a new binary see [How to Build a New Binary](#how-to-build-a-new-binary)

## Versions

This buildpack currently supports **Heroku 16** and **Heroku 20** and contains **ImageMagick 7.0.11-4 Q16 x86_64** https://imagemagick.org

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

### Prerequisites

- Docker installed and running in local dev environment. [Get Docker](https://docs.docker.com/get-docker/)

### Building the binaries

To re-build all the binaries, run:

```
$ make build
```

To build the binary for a specific Heroku stack (for example, Heroku 16), run:

```
$ make build-heroku-16
```

Check the [currently supported versions](#versions).


The binary files will be updated in the `/build` folder. Commit and push to the repo.

### Clear cache(_Not Sure if this is necessary)
Since the installation is cached you might want to clean it out due to config changes.

1. `heroku plugins:install heroku-repo`
2. `heroku repo:purge_cache -app HEROKU_APP_NAME`

## Adding support to a new Stack

### Using the correct Docker image

Heroku provides [Docker images](https://hub.docker.com/r/heroku/heroku/tags?page=1&ordering=last_updated) that can be used to build code.

Those images can be referenced in `Makefile` in this repo to build ImageMagick for a new Stack.

```
build-heroku-20:
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build scripts/build_imagemagick imagemagick-heroku-20.tar.gz
```

In the example above we use the Docker image `heroku/heroku:20-build` as well as passing the variable `STACK` as `heroku-20` and the output binary file as `imagemagick-heroku-20.tar.gz`.

Choose the Docker image that suits your Stack and make the appropriate changes to `Makefile`.

### Adjusting the Build Script

The `/scripts/build_imagemagick` script is executed in the Docker image that was specified in `Makefile`. It will build ImageMagick with support to HEIC/HEIF based on the stack. A different Heroku stack that is not currently supported by this repository may require changes to the build script in order to succesfully compile the binary file.


## Credits
https://medium.com/@eplt/5-minutes-to-install-imagemagick-with-heic-support-on-ubuntu-18-04-digitalocean-fe2d09dcef1
https://github.com/brandoncc/heroku-buildpack-vips
https://github.com/steeple-dev/heroku-buildpack-imagemagick
https://github.com/retailzipline/heroku-buildpack-imagemagick-heif
