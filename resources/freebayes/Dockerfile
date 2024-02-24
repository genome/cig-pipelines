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
    wget \
  && apt-get clean -y

# FREEBAYES
WORKDIR /apps/freebayes
RUN wget https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-linux-amd64-static.gz \
  && find . -name freebayes\*.gz | xargs -I% gunzip % \
  && find . -name freebayes\* | xargs -I% ln % freebayes \
  && chmod 777 -R .

# CLEAN UP & ENVs
WORKDIR /
ENV PATH="/apps/freebayes:${PATH}"
