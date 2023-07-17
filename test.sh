#!/usr/bin/env bash

# Testing script for init_home.sh
docker build -t init-home-test . && docker run --rm -it init-home-test
