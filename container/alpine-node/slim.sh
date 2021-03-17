#!/bin/sh
# build alpine base docker image

docker build -f slim.dockerfile -t nxa/alpine-node:15.11-slim .