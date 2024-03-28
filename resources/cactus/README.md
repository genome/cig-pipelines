# Minigraph Cactus Graph Builder

Dockerfile for building pangenome graphs with minigraph-cactus.

## Cactus 

GitHub:   git@github.com:ComparativeGenomicsToolkit/cactus.git
Version:  2.50

## Scripts & Workflow

The *mcgb.sh* script is copied to */usr/local/bin*, and has been used to build smaller graphs. A WDL workflow is located at *wdl/pipelines/pangenome/mcgb.wdl*.

## Build

Docker:   mgibio/cactus:2.5.0-focal

*this build requires cloning cactus into the working directory*

```
$ git clone git@github.com:ComparativeGenomicsToolkit/cactus.git --single-branch --branch v2.5.0
$ docker build -t mgibio/cactus:2.5.0-focal .
```
