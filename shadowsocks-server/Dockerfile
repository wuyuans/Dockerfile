FROM golang:latest AS builder
RUN go get github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -v -o shadowsocks-server github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-server

FROM alpine:latest
MAINTAINER wuyuans
COPY --from=builder /go/shadowsocks-server ./
CMD /shadowsocks-server \
    -p ${SS_PORT:=8388} \
    -k ${SS_PASSWORD:=password} \
    -m ${SS_METHOD:=aes-256-cfb} \
    -t ${SS_TIMEOUT:=600}