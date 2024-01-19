FROM ubuntu:20.04

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt update && \
  apt install -y \
    build-essential \
    cmake \
    curl \
    git \
    libnss-sss \
    vim \
  && apt clean -y

WORKDIR /apps/rustybam/
WORKDIR /apps/build/
RUN curl https://sh.rustup.rs -o install_rust.sh && \
  bash install_rust.sh -y
RUN git clone --single-branch --depth 1 --branch v0.1.33 https://github.com/mrvollger/rustybam.git
WORKDIR rustybam/
RUN . /root/.cargo/env && \
  cargo build --release --target-dir /apps/rustybam/


WORKDIR /
RUN /root/.cargo/bin/rustup self uninstall -y
RUN rm -rf /apps/build/
RUN DEBIAN_FRONTEND=noninteractive apt-get remove -y \
  build-essential \
  git \
  && \
  apt-get autoremove -y && \
  apt-get clean -y
ENV PATH=/apps/rustybam/release:${PATH}
