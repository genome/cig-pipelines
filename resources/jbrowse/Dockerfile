FROM node:bullseye
LABEL maintainer=ebelter@wustl.edu

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt update \
  && apt install -y \
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
    tabix \
    vim \
    zlib1g-dev \
  && apt clean -y

ARG htslib_version=1.18
WORKDIR /tmp/build/
RUN curl -L https://github.com/samtools/samtools/releases/download/${htslib_version}/samtools-${htslib_version}.tar.bz2 --output samtools.tar.bz2 && \
   bunzip2 samtools.tar.bz2 && tar xf samtools.tar && \
   cd samtools-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install
RUN curl -L https://github.com/samtools/htslib/releases/download/${htslib_version}/htslib-${htslib_version}.tar.bz2 --output htslib.tar.bz2 && \
   bunzip2 htslib.tar.bz2 && tar xf htslib.tar && \
   cd htslib-${htslib_version} && \
   ./configure --prefix=/usr/local && make && make install

RUN npm install -g @jbrowse/cli

WORKDIR /apps/
RUN jbrowse create jbrowse
WORKDIR /apps/jbrowse
#npx serve .
