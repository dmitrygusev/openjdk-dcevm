#!/bin/bash

docker run -d --name dcevm-binaries openjdk-dcevm:8-jdk sleep 1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker cp 'dcevm-binaries:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/dcevm/' $DIR

docker stop dcevm-binaries
docker rm dcevm-binaries
