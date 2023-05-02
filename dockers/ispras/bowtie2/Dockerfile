FROM phusion/baseimage:master

ARG BOWTIE2_VERSION=2.1.0

ENV TERM=xterm-256color \
    BOWTIE2_URL=https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.1.0/bowtie2-2.1.0-linux-x86_64.zip/download


WORKDIR /usr/gitc

# Install dependencies
RUN set -eux; \
        apt-get update; \
        apt-get install -y \
            autoconf \
            automake \
            unzip \
            bash \
            wget \
    ; \
# Install bowtie2
    wget ${BOWTIE2_URL}; \
    mv download bowtie2-${BOWTIE2_VERSION}-linux-x86_64.zip; \
    unzip bowtie2-${BOWTIE2_VERSION}-linux-x86_64.zip; \
    cd bowtie2-${BOWTIE2_VERSION}/; \
    cp bowtie2* /usr/bin/; \

