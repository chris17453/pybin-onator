 
.DEFAULT: help

.PHONY: all build test

help:
	@echo "make build          | build docker image"

build:
	@docker build -t pybin-onator .

test:
	@docker run -it \
           -v $(shell pwd)/build/:/build/ \
           -e PY_SCRIPT=test.py \
           -e PY_SCRIPT_OUTPUT=calvin.ascii \
           pybin-onator
	@build/calvin.ascii
