FROM broadinstitute/picard:2.27.4

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libnss-sss \
    less && \
    apt-get clean 

WORKDIR /apps/scripts
RUN curl http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/gtfToGenePred -o gtfToGenePred
COPY /scripts/ ./
RUN chmod -R a+rwx ./

ENV PATH="/apps/scripts:${PATH}"
WORKDIR /
