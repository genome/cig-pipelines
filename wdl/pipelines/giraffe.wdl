version development

import "wdl/structs/runenv.wdl"
import "wdl/tasks/deepvariant.wdl"
import "wdl/tasks/samtools.wdl"
import "wdl/tasks/vg/giraffe.wdl"
import "wdl/tasks/vg/stats.wdl"
import "wdl/tasks/vg/surject.wdl"

workflow giraffe_pipeline {

  input {
    String sample
    Array[File] fastqs 
    File min
    File dist
    File gbz
    String docker = "quay.io/vgteam/vg:v1.48.0" #"quay.io/vgteam/vg@sha256:62a1177ab6feb76de6a19af7ad34352bea02cab8aa2996470d9d2b40b3190fe8"
    Int cpu = 32
    Int memory = 500
  }

  RunEnv giraffe_runenv = {
    "docker": docker,
    "cpu": cpu,
    "memory": memory,
    "disks": 20,
  }

  call giraffe.run_giraffe { input:
    sample=sample,
    fastqs=fastqs,
    min=min,
    dist=dist,
    gbz=gbz,
    runenv=giraffe_runenv,
  }

  RunEnv runenv_vg = {
    "docker": docker,
    "cpu": 8,
    "memory": 64,
    "disks": 20,
  }

  call stats.run_stats { input:
    gam=run_giraffe.gam,
    runenv=runenv_vg,
  }

  call surject.run_surject { input:
    gam=run_giraffe.gam,
    sample=sample,
    gbz=gbz,
    runenv=runenv_vg,
  }

  RunEnv runenv_samtools = {
    "docker": docker, # vg 1.48.0 docker has samtools 1.10
    "cpu": 4,
    "memory": 20,
    "disks": 20,
  }

  call samtools.sort as samtools_sort { input:
    bam=run_surject.bam,
    runenv=runenv_samtools,
  }

  call samtools.stat as samtools_stat { input:
    bam=samtools_stat.bam,
    runenv=runenv_samtools,
  }

  RunEnv runenv = {
    "docker": "google/deepvariant:1.5.0", # "google/deepvariant:1.5.0-gpu"
    "cpu": 9,
    "memory": 48,
    "disks": 20,
  }

  call deepvariant.deep_variant { input:
    name=name,
    bam=samtools_sort.sorted_bam,
    bai=surject.bai,
    reference=reference,
    runenv=runenv,
  }

  output {
    File gam = run_giraffe.gam
    File gam_stats = run_stats.stats
    File bam = samtools_sort.bam
    File bai = surject.bai
    File bam_stats = samtools_stat.stats
    File vcf = deep_variant.vcf
  }
}