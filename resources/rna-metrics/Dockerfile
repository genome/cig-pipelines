FROM broadinstitute/picard:2.27.4

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libnss-sss \
    less \
    python3 \
    python3-pip && \
    apt-get clean 

WORKDIR /apps/scripts
RUN curl http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/gtfToGenePred -o gtfToGenePred
COPY /scripts/ ./
RUN chmod -R a+rwx ./

WORKDIR /tmp/
RUN git clone https://github.com/ebelter/mgi.git
WORKDIR /tmp/mgi/
RUN ln -s setup.cig-metrics.py setup.py && \
  python3 -m pip install --prefix=/usr/local .

ENV PATH="/apps/scripts:${PATH}"
WORKDIR /
