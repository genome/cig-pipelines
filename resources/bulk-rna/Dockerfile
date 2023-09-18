FROM ebelter/rna-seq-pipeline:1.2.11

# GFF Read
WORKDIR /apps/gffread/build/
RUN git clone https://github.com/gpertea/gffread
WORKDIR gffread
RUN make release && \
  mv gff* ../../ && \
  cd ../../ && \
  rm -rf build/

WORKDIR /apps/scripts/
COPY scripts/* ./
RUN chmod -R ugo+rxw ./

# ENV
ENV PATH=/apps/scripts:/apps/gffread:/apps/RSEM-1.2.31:/apps/kallisto_linux-v0.44.0:/apps/${STAR_VERSION}/bin/Linux_x86_64:/apps/kentutils_v385_bin_bulkrna:${PATH}

WORKDIR /
