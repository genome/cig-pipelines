#!/bin/bash
set -ex

ref_fasta_gz=$1      # Reference genome assembly in gzipped fasta format.
anno_gtf_gz=$2       # Gene annotation in gzipped gtf format
anno=$3              # Annotation (e.g. 'v24')
genome=$4            # Genome (e.g. 'GRCh38')
ncpu=$5

echo "-- Unzipping reference files..."
ref_fasta=${ref_fasta_gz%.gz}
ref_root=${ref_fasta%.fasta}
ref_root=${ref_root%.fa}
gunzip -c $ref_fasta_gz > $ref_fasta
anno_gtf=${anno_gtf_gz%.gz}
anno_root=${anno_gtf%.gtf}
gunzip -c $anno_gtf_gz > $anno_gtf

archive_file="${genome}_${anno}_starIndex.tgz"
echo "-- Results will be: '${archive_file}'."

echo "-- Build index..."
set -x
mkdir out
STAR --runMode genomeGenerate --genomeFastaFiles $ref_fasta \
     --sjdbOverhang 149 --sjdbGTFfile $anno_gtf --runThreadN $ncpu --genomeDir out/ \
     --outFileNamePrefix out
set +x

# Attempt to make bamCommentLines.txt, which should be reviewed. NOTE tabs handled by assignment.
echo "-- Create bam header..."
set -x
refComment="@CO\tREFID:$(basename ${ref_root})"
annotationComment="@CO\tANNID:$(basename ${anno_root})"
echo -e ${refComment} > out/star_bamCommentLines.txt
echo -e ${annotationComment} >> out/star_bamCommentLines.txt
echo `cat "out/star_bamCommentLines.txt"`
set +x

echo "-- Tar up results..."
set -x
tar -czvf $archive_file out/
set +x

echo "-- The results..."
ls -l $archive_file
