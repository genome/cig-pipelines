FROM ubuntu:20.04
LABEL maintainer=ebelter@wustl.edu

ENV LC_ALL=C
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} | tee /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y \
    less \
    libnss-sss \
    openjdk-8-jdk \
    wget \
    vim \
  && apt-get clean -y

# ABRA2
WORKDIR /apps/abra2
RUN wget https://github.com/mozack/abra2/releases/download/v2.23/abra2-2.23.jar \
  && find . -name abra2-\*.jar | head -1 | xargs -I% ln % abra2.jar

# CLEAN UP
WORKDIR /
