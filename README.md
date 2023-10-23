# CIG Group @ MGI Workflows

The Collaborative and Intergrative Genomics (CIG) is a group in the [McDonnell Genome Institute](https://www.genome.wustl.edu/) (MGI) at the [Washington University School of Medicine](https://medicine.wustl.edu/) (WUSM).

## Overview

In this repo, we share pipelines, workflows, and tools in the form of [WDL](https://github.com/openwdl/wdl/blob/main/versions/1.1/SPEC.md) with corresponding Dockerfiles and scripts focused on reusable, reproducible analysis pipelines for genomics data.  

## Repo Structure

| Path | Description |
| --- | --- |
| pipelines     | assorted unassimilated pipelines |
| wdl           | parent directory containing all CWL tool and workflow definitions |
| wdl/pipelines | start to end process that typically contain workflows, tools, & tasks to produce final outputs |
| wdl/tasks     | these wrap command line interfaces or scripts |
| wdl/tools     | workflows that combine multiple tasks to produce intermediate/final outputs |
| wdl/structs   | data types for inputs to tools and workflows |
