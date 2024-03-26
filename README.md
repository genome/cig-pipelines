# CIG Group @ MGI Workflows

The Collaborative and Intergrative Genomics (CIG) is a group in the [McDonnell Genome Institute](https://www.genome.wustl.edu/) (MGI) at the [Washington University School of Medicine](https://medicine.wustl.edu/) (WUSM).

## Overview

In this repo, we share pipelines, workflows, and tools in the form of [WDL](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md) with corresponding Dockerfiles and scripts focused on reusable, reproducible analysis pipelines for genomics data.  

## Repo Structure

| Path | Description |
| --- | --- |
| resources     | directories of packages containing dockers and basic scripts |
| wdl           | workflow definitions written in WDL (cromwell) |
| wdl/pipelines | start to end process that typically contain tools & tasks to produce final outputs |
| wdl/tasks     | these wrap command line interfaces or scripts and cannot be run separately |
| wdl/tools     | workflows that combine multiple tasks to produce intermediate/final outputs |
| wdl/structs   | data types for inputs to tools and workflows |
| scripts       | parent directory by containing dockers and basic scripts |
| imoprt        | assorted unassimilated pipelines, code, etc. |
