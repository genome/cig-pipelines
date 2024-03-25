FROM ubuntu:20.04
LABEL maintainer=ebelter@wustl.edu

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

# DEPs
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y \
    cmake \
    curl \
    g++ \
    gcc \
    less \
    libbz2-dev \
    liblzma-dev \
    libnss-sss \
    libtabixpp-dev \
    meson \
    pkg-config \
    wget \
    zlib1g-dev \
  && apt-get clean -y

# HTSlib
ARG htslib_version=1.18
WORKDIR /tmp/build/
RUN curl -L https://github.com/samtools/htslib/releases/download/${htslib_version}/htslib-${htslib_version}.tar.bz2 --output htslib.tar.bz2 && \
   bunzip2 htslib.tar.bz2 && tar xf htslib.tar && \
   cd htslib-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install

# FREEBAYES
WORKDIR /apps/freebayes
RUN wget https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-src.tar.gz && \
    tar xzvvf freebayes-1.3.6-src.tar.gz
WORKDIR freebayes/
RUN meson build -Dstatic=true -Dprefer_system_deps=false --buildtype release
WORKDIR build/
RUN ninja && cp freebayes bamleftalign /usr/local/bin/

# CLEAN UP & ENVs
WORKDIR /
RUN rm -rf /tmp/build/ /apps/

ENV PATH="/apps/freebayes:${PATH}"
