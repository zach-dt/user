#!/usr/bin/env sh

set -ev

#docker build -t jbraeuer/user:latest .
docker build -t jbraeuer/user:latest -f docker/user/Dockerfile .

docker push jbraeuer/user:latest
