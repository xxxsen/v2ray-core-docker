FROM golang:1.20

ARG VERSION=

WORKDIR /data
RUN git clone https://github.com/v2fly/v2ray-core core
WORKDIR /data/core
RUN git checkout $VERSION && CGO_ENABLED=0 go build -buildvcs=false -o v2ray -a -tags netgo -trimpath -ldflags "-s -w -buildid=" ./main

FROM alpine:3.12
COPY --from=0 /data/core/v2ray /bin

