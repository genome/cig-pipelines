# MINIMAP2
FROM debian:buster
LABEL maintainer=ebelter@wustl.edu

RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
     bzip2 \
     curl \
     gcc \
     git \
     make \
     less \
     libbz2-dev \
     liblzma-dev \
     libncurses-dev \
     libnss-sss \
     libz-dev \
     gcc \
     vim \
     zlib1g-dev \
  && apt clean

# SAMTOOLS & BCFTOOLS & HTSlib
ARG htslib_version=1.18
WORKDIR /tmp/build/
RUN curl -L https://github.com/samtools/samtools/releases/download/${htslib_version}/samtools-${htslib_version}.tar.bz2 --output samtools.tar.bz2 && \
   bunzip2 samtools.tar.bz2 && tar xf samtools.tar && \
   cd samtools-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install
RUN curl -L https://github.com/samtools/bcftools/releases/download/${htslib_version}/bcftools-${htslib_version}.tar.bz2 --output bcftools.tar.bz2 && \
   bunzip2 bcftools.tar.bz2 && tar xf bcftools.tar && \
   cd bcftools-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install
RUN curl -L https://github.com/samtools/htslib/releases/download/${htslib_version}/htslib-${htslib_version}.tar.bz2 --output htslib.tar.bz2 && \
   bunzip2 htslib.tar.bz2 && tar xf htslib.tar && \
   cd htslib-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install

# MINIMAP2
WORKDIR /tmp/minimap2
RUN curl -L https://github.com/lh3/minimap2/releases/download/v2.26/minimap2-2.26_x64-linux.tar.bz2 --output minimap.tar.bz2 && \
  tar -jxvf minimap.tar.bz2 && \
  cp minimap2-2.26_x64-linux/minimap2 /usr/local/bin/

WORKDIR /
RUN rm -rf /tmp/build/
RUN rm -rf /tmp/mimnimap2/
