version development

import "../../structs/runenv.wdl"
import "../../tasks/gatk/haplotype_caller.wdl"

workflow haplotype_caller {
    meta {
        author: "Eddie Belter"
        version: "0.1"
        description: "GATK HaplotypeCaller"
    }

    input {
        File bam 
        Directory reference
        String docker = "broadinstitute/gatk:4.3.0.0"
        Int cpu = 4
        Int memory = 20
    }

    RunEnv runenv = {
      "docker": docker,
      "cpu": cpu,
      "memory": memory,
    }

    call haplotype_caller.run_haplotype_caller { input:
        bam=bam,
        reference=reference,
        runenv=runenv
    }

    output {
        File vcf = run_haplotype_caller.vcf
    }
}
