# CIG Group @ MGI Workflows

The Collaborative and Intergrative Genomics (CIG) is a group in the [McDonnell Genome Institute](https://www.genome.wustl.edu/) (MGI) at the [Washington University School of Medicine](https://medicine.wustl.edu/) (WUSM).

## Overview

In this repo, we share pipelines, workflows, and tools in the form of [WDL](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md) with corresponding Dockerfiles and scripts focused on reusable, reproducible analysis pipelines for genomics data.  

## Repo Structure

| Path | Description |
| --- | --- |
| resources     | directories of namespaces containing dockers and scripts |
| wdl           | workflow definitions written in WDL (cromwell) |
| wdl/pipelines | full start to end workflows that produce outputs from multiple steps |
| wdl/tasks     | wrapped command line interfaces and scripts (must be incorporated into tools/pipelines) |
| wdl/tools     | stand alone workflows that combine tasks to produce singular outputs |
| wdl/structs   | data structures and types for pipelines, tools, and tasks |
| scripts       | scripts for this repository |
| import        | assorted unassimilated pipelines, code, etc. |
