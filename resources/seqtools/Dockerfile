# SEQTOOLS - A docker with handy genome tools
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

# SAMTOOLS
ARG samtools_version=1.15.1
ARG prog=samtools
WORKDIR /tmp/build/
RUN curl -L https://github.com/samtools/${prog}/releases/download/${samtools_version}/${prog}-${samtools_version}.tar.bz2 --output ${prog}.tar.bz2 && \
   bunzip2 ${prog}.tar.bz2 && tar xf ${prog}.tar && \
   cd ${prog}-${samtools_version} && \
   ./configure --prefix=/usr/local && make && make install

# SEQ-TK
ARG seqtk_version=v1.4
WORKDIR /tmp/
RUN git clone https://github.com/lh3/seqtk.git --branch ${seqtk_version} --single-branch && cd seqtk && make && make install
RUN chmod -R a+rwx ./

WORKDIR /
RUN rm -rf /tmp/build/
RUN rm -rf /tmp/seqtk/
