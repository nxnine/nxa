#!/bin/sh
# build alpine base docker image

docker build -f Dockerfile -t nxa/alpine-node:15.11 .