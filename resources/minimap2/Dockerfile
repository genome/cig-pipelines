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
ARG MINIMAP2_VERSION="v2.28"
WORKDIR /tmp/build/
RUN git clone --single-branch --branch "${MINIMAP2_VERSION}" https://github.com/lh3/minimap2.git
WORKDIR minimap2/
RUN make && \
  cp minimap2 /usr/local/bin/ && \
  cp misc/paftools.js /usr/local/bin/paftools
WORKDIR /tmp/build/
RUN wget https://github.com/attractivechaos/k8/releases/download/v1.0/k8-1.0.tar.bz2 && \
  tar -jxf k8-1.0.tar.bz2 && \
  cp k8-1.0/k8-x86_64-Linux /usr/local/bin/k8

WORKDIR /
RUN rm -rf /tmp/build/
