FROM debian:buster
LABEL maintainer=ebelter@wustl.edu

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt update \
  && apt install -y \
    build-essential \
    bzip2 \
    cmake \
    curl \
    gcc \
    git \
    make \
    less \
    libnss-sss \
    libbz2-dev \
    liblzma-dev \
    libncurses-dev \
    libnss-sss \
    libz-dev \
    wget \
    vim \
    zlib1g-dev \
  && apt clean -y

# RUSTYBAM
WORKDIR /apps/rustybam/
WORKDIR /tmp/build/
RUN wget https://sh.rustup.rs -O install_rust.sh && \
  bash install_rust.sh -y
RUN git clone --single-branch --depth 1 --branch v0.1.33 https://github.com/mrvollger/rustybam.git
WORKDIR rustybam/
RUN . /root/.cargo/env && \
  cargo build --release --target-dir /apps/rustybam/

# BEDOPs
WORKDIR /apps/bedops/
RUN wget https://github.com/bedops/bedops/releases/download/v2.4.41/bedops_linux_x86_64-v2.4.41.tar.bz2 -O bedops_linux_x86_64-v2.4.41.tar.bz2 \
  && tar xjvvf bedops_linux_x86_64-v2.4.41.tar.bz2 \
  && rm -rf bedops_linux_x86_64-v2.4.41.tar.bz2

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

# CLEAN UP
WORKDIR /
RUN /root/.cargo/bin/rustup self uninstall -y
RUN rm -rf /apps/build/ /tmp/build/
RUN DEBIAN_FRONTEND=noninteractive apt-get remove -y \
  build-essential \
  git \
  && \
  apt-get autoremove -y && \
  apt-get clean -y
ENV PATH=/apps/bedops/bin:/apps/rustybam/release:${PATH}
