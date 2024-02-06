FROM ubuntu:20.04

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt update && \
  apt install -y \
    build-essential \
    bzip2 \
    cmake \
    git \
    libnss-sss \
    wget \
    vim \
  && apt clean -y

WORKDIR /apps/rustybam/
WORKDIR /apps/build/
RUN wget https://sh.rustup.rs -O install_rust.sh && \
  bash install_rust.sh -y
RUN git clone --single-branch --depth 1 --branch v0.1.33 https://github.com/mrvollger/rustybam.git
WORKDIR rustybam/
RUN . /root/.cargo/env && \
  cargo build --release --target-dir /apps/rustybam/

WORKDIR /apps/bedops/
RUN wget https://github.com/bedops/bedops/releases/download/v2.4.41/bedops_linux_x86_64-v2.4.41.tar.bz2 -O bedops_linux_x86_64-v2.4.41.tar.bz2 \
  && tar xjvvf bedops_linux_x86_64-v2.4.41.tar.bz2 \
  && rm -rf bedops_linux_x86_64-v2.4.41.tar.bz2

WORKDIR /
RUN /root/.cargo/bin/rustup self uninstall -y
RUN rm -rf /apps/build/
RUN DEBIAN_FRONTEND=noninteractive apt-get remove -y \
  build-essential \
  git \
  && \
  apt-get autoremove -y && \
  apt-get clean -y
ENV PATH=/apps/bedops/bin:/apps/rustybam/release:${PATH}
