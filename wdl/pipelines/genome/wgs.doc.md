# Genome WGS Pipeline

Map WGS fastqs using BWA-MEM and call variants with deep variant. This is the MGI Wang Lab standard for processing WGS data.

## Pipeline Chart
```mermaid
  flowchart TB;
      i1([SAMPLE]);
      i2([FASTQs]);
      i3([IDX]);
      s1[UNTAR IDX];
      s2[BWA-MEM];
      s3[MERGE];
      s4[SAMTOOLS SORT];
      s5[PICARD MARKDUP];
      s6[SAMTOOLS STAT];
      s7[SAMTOOLS INDEX];
      s8[DEEPVARIANT];
      i3-->s1;
      i1-->s2; i2-->s2; s1--REF PATH-->s2;
      s2--BAMs-->s3;
      s3--BAM-->s4;
      s4--BAM-->s5;
      s5--BAM-->s6;
      s5--BAM-->s7;
      s7--BAI-->s8;
      s5--BAM-->s8;
```

## Pipeline Files
* wgs.wdl - WDL pipeline
* wgs.inputs.json - pipeline inputs with place holders
* wgs.outputs.yaml - steps and outputs to be copied after pipeline run
* wgs.imports.zip - imports used in the WDL
* wgs.imports.README - this file, documenting the pipeline

## Inputs
* name [String] - base name for outputs
* fastqs [File] - an array of an 2 arrays, one each for read1 and read2 fastqs
* idx [File] - tarred BWA index (made from bwa build_idx workflow)

## Steps
### Untar the BWA Reference [reference]
#### input
* idx [inputs.idx]
#### output
* reference - untarred BWA idx

### Map FASTQs with BWA MEM [align]
#### input
* name [name from workflow inputs]
* fastqs [fastqs from workflow inputs]
* reference [path from reference]
####output:
* bam

### Merge Bams [merge]
#### input
* name [name from workflow inputs]
* bams [bam(s) from align]
#### output:
* merged_bam

### Samtools Sort BAM by Coordinates [sort]
The bam needs to be sorted by coordinate to run addtional analyses
#### input
* bam [merged_bam from merge]
#### output
* sorted_bam

### Picard Mark Duplicates [markdup]
#### input
* name [name from workflow inputs]
* bam [sorted_bam from sort]
#### output
* dedup_bam
* metrics

### Samtools Index [index]
#### input
* bam [dedup_bam from markdup]
#### output
* bai [bam index file]

### Samtools Stat [stat]
#### input
* bam [dedup_bam from markdup]
#### output
* stats [samtools stat file]

### Deep Variant [dv]
* bam [dedup_bam from markdup]
* reference [path from reference]
#### output
* vcf

## Outputs
* bam [dedup_bam from markdup]
* bai [bai from index]
* vcf [vcf from dv]
* stats [stats from stat]
* dedup_metrics [metrics from markdup]
