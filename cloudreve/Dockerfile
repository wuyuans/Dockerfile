FROM golang:1.14.1-alpine3.11 as builder

ARG VERSION="3.1.1"

WORKDIR /src

RUN apk update \
    && apk add git yarn build-base gcc abuild binutils binutils-doc gcc-doc

RUN git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git

RUN cd /src/Cloudreve/assets \
    && yarn install \
    && yarn run build

RUN cd /src/Cloudreve \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/ -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f \
    && git checkout ${VERSION} \
    && export COMMIT_SHA=$(git rev-parse --short HEAD) \
    && go build -a -o cloudreve -ldflags " -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'"

FROM alpine:3.11

WORKDIR /cloudreve

COPY --from=builder /src/Cloudreve/cloudreve ./

RUN apk add --no-cache tzdata ca-certificates\
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && chmod +x ./cloudreve

VOLUME ["/cloudreve/uploads","/cloudreve/conf.ini", "/cloudreve/cloudreve.db"]

EXPOSE 5212

ENTRYPOINT ["./cloudreve"]