FROM alpine

ARG VERSION=6.9.1
ARG ARCH=x86_64

WORKDIR /app

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --no-cache curl tzdata tar gzip ca-certificates && \
    update-ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -o ddns-go_${VERSION}_linux_${ARCH}.tar.gz https://hub.openeeds.com/https://github.com/jeessy2/ddns-go/releases/download/v${VERSION}/ddns-go_${VERSION}_linux_${ARCH}.tar.gz && \
    tar -xf ddns-go_${VERSION}_linux_${ARCH}.tar.gz && \
    rm -rf ddns-go_${VERSION}_linux_${ARCH}.tar.gz
 
EXPOSE 9876
ENTRYPOINT ["/app/ddns-go"]
CMD ["-l", ":9876", "-f", "300"]