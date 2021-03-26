build: build-heroku-16 build-heroku-20

build-heroku-16:
	@echo "Building imagemagick in Docker for heroku-16..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-16" -w /buildpack heroku/heroku:16-build scripts/build_imagemagick imagemagick-heroku-16.tar.gz

build-heroku-20:
	@echo "Building imagemagick in Docker for heroku-20..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build scripts/build_imagemagick imagemagick-heroku-20.tar.gz
