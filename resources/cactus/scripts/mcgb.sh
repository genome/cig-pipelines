#!/bin/bash
read -r -d '' usage << EOM
DESC:  Build a pangenome grpah with minigraph-cactus
USAGE: ${0} SEQFILE REF CPU MEM OUT_PREFIX
EOM
set -ex
if [ -z "${4}" ]; then
    echo "${usage}"
    echo "ERROR: Missing param BED, PAF,FASTA, or OUT_FASTA"
    exit 2
fi
SEQFILE="${1}"
if [ ! -e ${SEQFILE} ]; then
    echo "${usage}"
    echo "ERROR: Seqfile <${SEQFILE}> does not exist!"
    exit 2
fi
REF="${2}"
if [ -z "${REF}" ]; then
    echo "${usage}"
    echo "ERROR: Seqfile <${SEQFILE}> does not exist!"
    exit 2
fi
CPU="${3}"
if [ -z "${CPU}" ]; then
    CPU=1
fi
MEMORY="${4}"
if [ -z "${MEMORY}" ]; then
    MEMORY=16
fi
OUT_PREFIX="${5}"
if [ -z "${OUT_PREFIX}" ]; then
    BN="pangenome"
    OUT="out"
else
    BN=$(basename "${OUT_PREFIX}")
    OUT=$(dirname "${OUT_PREFIX}")
fi
mkdir -p "${OUT}"

JOBSTORE='jobstore'
WORKDIR=$(mktemp -d)
function cleanup {      
    rm -rf "${WORKDIR}" "${JOBSTORE}"
}
trap cleanup EXIT

SV_GFA="${OUT}/${BN}.sv.gfa"
rm -rf "${JOBSTORE}"
cactus-minigraph ${JOBSTORE} ${SEQFILE} ${SV_GFA} --reference ${REF} --maxCores ${CPU} --maxMemory ${MEMORY}G --binariesMode 'local' --defaultDisk 100G

PAF="${OUT}/${BN}.paf"
FASTA="${OUT}/${BN}.sv.gfa.fasta"
rm -rf ${JOBSTORE}
cactus-graphmap ${JOBSTORE} ${SEQFILE} ${SV_GFA} ${PAF} --outputFasta ${FASTA} --reference ${REF} --maxMemory ${MEMORY}G --binariesMode 'local' --defaultDisk 100G

CHROMS="${OUT}/chroms"
rm -rf ${JOBSTORE}
cactus-graphmap-split ${JOBSTORE} ${SEQFILE} ${SV_GFA} ${PAF} --outDir ${CHROMS} --reference ${REF} --maxMemory ${MEMORY}G --binariesMode 'local' --defaultDisk 100G

CHROMFILE=$(find ${CHROMS} -name chromfile.txt)
ALIGNMENTS="${OUT}/alignments"
rm -rf ${JOBSTORE}
cactus-align ${JOBSTORE} ${CHROMFILE} ${ALIGNMENTS} --batch --pangenome --reference ${REF} --outVG --maxMemory ${MEMORY}G --maxCores ${CPU} --workDir ${WORKDIR} --binariesMode local
#cactus-align ${JOBSTORE} ${CHROMFILE} ${ALIGNMENTS} --batch --pangenome --reference ${REF} --outVG --maxMemory ${MEMORY}G --defaultDisk 100G --binariesMode local

rm -rf ${JOBSTORE}
cactus-graphmap-join ${JOBSTORE} --vg ${ALIGNMENTS}/*.vg --hal ${ALIGNMENTS}/*.hal --outDir "${OUT}" --outName "${BN}" --reference "${REF}" --vcf --giraffe clip --maxMemory ${MEMORY}G --binariesMode local
