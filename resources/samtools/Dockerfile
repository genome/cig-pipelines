FROM debian:buster
RUN apt update && \
  apt install -y \
     bzip2 \
     curl \
     make \
     less \
     libbz2-dev \
     liblzma-dev \
     libncurses-dev \
     libnss-sss \
     gcc \
     vim \
     zlib1g-dev \
  && apt clean

ARG version=1.15.1
ARG prog=samtools

WORKDIR /tmp/build/
RUN curl -L https://github.com/samtools/${prog}/releases/download/${version}/${prog}-${version}.tar.bz2 --output ${prog}.tar.bz2 && \
   bunzip2 ${prog}.tar.bz2 && tar xf ${prog}.tar && \
   cd ${prog}-${version} && \
   ./configure --prefix=/usr/local && make && make install

WORKDIR /
RUN rm -rf /tmp/build/
