FROM alpine:3.15.5

RUN apk add --no-cache \
    lsof \
    nethogs \
    procps \
    nfs-utils \
    tcpdump

RUN mkdir -p /scripts
COPY performance.sh /scripts

WORKDIR /scripts
RUN chmod +x performance.sh

CMD ["sh", "/scripts/performance.sh"]