#!/bin/sh
# build alpine base docker image

docker build -f build.ockerfile -t nxa/alpine-deno:1.8.1 .