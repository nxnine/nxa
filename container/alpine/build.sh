#!/bin/sh
# build alpine base docker image

docker build -f Dockerfile -t nxa/alpine:3.13.2 .