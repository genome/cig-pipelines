# STRINGTIE2
FROM ubuntu:focal
LABEL maintainer=ebelter@wustl.edu

# DEPS
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    curl \
    git \
    less \
    libbz2-dev \
    libhts-dev \
    liblzma-dev \
    libnss-sss \
    make \
  && \
  apt-get clean all

# STRINGTIE
WORKDIR /tmp/
RUN git clone --depth 1 --branch v2.0 https://github.com/mpertea/stringtie2 && \
  cd stringtie2/ && make release && cp stringtie prepDE.py /usr/local/bin/

# CLEANUP, ENV, ETC.
WORKDIR /
RUN rm -rf /tmp/strtingtie2/
