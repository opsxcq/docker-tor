FROM debian:jessie

LABEL maintainer "opsxcq@strm.sh"

RUN apt-get update && \
    apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    ntpdate \
    tor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --system --uid 666 -M --shell /usr/sbin/nologin tor

COPY main.sh /

RUN mkdir /web && \
    chown -R tor /web /etc/tor

VOLUME /web

USER tor

ENTRYPOINT ["/main.sh"]
CMD ["default"]
