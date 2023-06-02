version development

import "wdl/structs/runenv.wdl"
import "wdl/tasks/bwa/align.wdl"
import "wdl/tasks/bwa/idx.wdl"
import "wdl/tasks/gatk/bqsr.wdl"
import "wdl/tasks/gatk/haplotype_caller.wdl"
import "wdl/tasks/picard/markdup.wdl"
import "wdl/tasks/samtools.wdl"

workflow align_and_call {
    meta {
        author: "Eddie Belter"
        version: "0.1"
        description: "Align and Call Variants Pipleine"
    }

    input {
        String name
        Array[File] fastqs  # read fastqs
        File idx            # tarred BWA index
        File known_sites    # vcf 
    }

    RunEnv runenv_idx = {
      "docker": "ebelter/linux-tk:latest",
      "cpu": 1,
      "memory": 4,
      "disks": 20,

    }
    call idx.run_untar_idx as reference { input:
        idx=idx,
        runenv=runenv_idx,
    }

    RunEnv runenv_bwa = {
      "docker": "ebelter/bwa:0.7.17",
      "cpu": 8,
      "memory": 48,
      "disks": 20,
    }

    call align.run_bwa_mem as align { input:
        name=name,
        fastqs=fastqs,
        reference=reference.path,
        runenv=runenv_bwa,
    }

    RunEnv runenv_samtools = {
      "docker": "ebelter/samtools:1.15.1",
      "cpu": 1,
      "memory": 4,
      "disks": 20,
    }
    call samtools.stat as samtools_stat { input:
        bam=align.bam,
        runenv=runenv_samtools,
    } 

    call samtools.sort as samtools_sort { input:
        bam=align.bam,
        runenv=runenv_samtools,
    } 

    RunEnv runenv_picard = {
      "docker": "ebelter/picard:2.27.4",
      "cpu": 4,
      "memory": 20,
      "disks": 20,
    }

    call markdup.run_markdup { input:
        name=name,
        bam=samtools_sort.sorted_bam,
        runenv=runenv_picard,
    }

    RunEnv runenv_gatk = {
      "docker": "broadinstitute/gatk:4.3.0.0",
      "cpu": 4,
      "memory": 20,
      "disks": 20,
    }
 
    call bqsr.run_bqsr { input:
        bam=run_markdup.dedup_bam,
        reference=reference.path,
        known_sites=known_sites,
        runenv=runenv_gatk,
    }

    call bqsr.apply_bqsr as bqsr { input:
        bam=run_markdup.dedup_bam,
        reference=reference.path,
        table=run_bqsr.table,
        runenv=runenv_gatk,
    }

    call haplotype_caller.run_haplotype_caller as hc { input:
        bam=bqsr.recal_bam,
        reference=reference.path,
        runenv=runenv_gatk,
    }

    output {
        File bam = bqsr.recal_bam
        File vcf = hc.vcf
        File dedup_metrics = run_markdup.metrics
        File stats = samtools_stat.stats
    }
}
