FROM golang:latest AS builder
RUN go get github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-local
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -v -o shadowsocks-local github.com/shadowsocks/shadowsocks-go/cmd/shadowsocks-local

FROM alpine:latest
MAINTAINER wuyuans
COPY --from=builder /go/shadowsocks-local ./
CMD /shadowsocks-local \
    -s ${SS_ADDRESS:=localhost} \
    -p ${SS_PORT:=8388} \
    -k ${SS_PASSWORD:=password} \
    -m ${SS_METHOD:=aes-256-cfb} \
    -b ${CLIENT_ADDRESS:=localhost} \
    -l ${CLIENT_PORT:=8008}