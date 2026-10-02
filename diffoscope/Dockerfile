FROM debian:13.7-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y diffoscope && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash user

USER user
WORKDIR /home/user

ENTRYPOINT [ "/usr/bin/diffoscope" ]