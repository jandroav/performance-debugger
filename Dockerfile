FROM alpine:3.15.5

RUN apk add --no-cache \
    htop \
    iftop \
    iotop \
    iptraf-ng \
    lsof \
    nethogs \
    procps \
    tcpdump

RUN mkdir -p /scripts
COPY performance.sh /scripts

WORKDIR /scripts
RUN chmod +x performance.sh

CMD ["sh", "/scripts/performance.sh"]