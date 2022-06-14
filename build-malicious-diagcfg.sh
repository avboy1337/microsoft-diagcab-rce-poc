#!/bin/sh

for i in "$@"; do
    case $i in
    --url)
        RHOST="$2"
        shift;shift;
        ;;
    *)    
        ;;
    esac
done

CFG="custom.diagcfg"

cp ${CFG}.tpl ${CFG}

sed -i "s/WEBDAV_URL/${RHOST}/g" ${CFG}