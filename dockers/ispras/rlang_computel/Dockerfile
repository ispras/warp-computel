FROM phusion/baseimage:master

ENV TERM=xterm-256color 

WORKDIR /usr/gitc

# Install dependencies
RUN set -eux; \
        apt-get update; \
        apt-get install -y \
            autoconf \
            automake \
            bash \
            r-base \
            r-cran-seqinr \
            r-cran-psych \
            && rm -rf /var/lib/apt/lists/*;

