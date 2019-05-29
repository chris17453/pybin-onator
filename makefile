 
.DEFAULT: help

.PHONY: all build

help:
	@echo "make build          | build docker image"

build:
	@docker build -t pybin-onator .