#!/bin/sh
# build alpine base docker image

docker build -f Dockerfile -t nxa/alpine-deno:1.8.1 .