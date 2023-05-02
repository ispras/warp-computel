FROM phusion/baseimage:master

ARG SAMTOOLS_VERSION=1.11

ENV TERM=xterm-256color \
    SAMTOOLS_URL=https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2

WORKDIR /usr/gitc

# Install dependencies
RUN set -eux; \
        apt-get update; \
        apt-get install -y \
            autoconf \
            automake \
            bash \
            libbz2-dev \
            xz-utils \
            zlib1g-dev \
            gcc \
            make \
            liblzma-dev \
            musl-dev \
            ncurses-dev \
            perl \
            wget \
    ; \
# Install samtools
    mkdir temp; \
    cd temp; \
    \
    wget ${SAMTOOLS_URL}; \
    tar -xf samtools-${SAMTOOLS_VERSION}.tar.bz2; \
    cd samtools-${SAMTOOLS_VERSION}; \
    \
    ./configure; \
    make; \
    make install; \
    \
    rm -r /usr/gitc/temp;

