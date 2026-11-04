#!/bin/bash
#SBATCH --job-name=fastqc_raw
#SBATCH --partition=scu-cpu
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=24:00:00
#SBATCH --output=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/fastqc_%j.log

set -euo pipefail
source ~/yes/etc/profile.d/conda.sh
conda activate /athena/linglab/scratch/yil4013/ICI/envs/qc

IN=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/raw_data
OUT=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/qc_raw

mkdir -p "$OUT"

fastqc "$IN"/*.fastq.gz --outdir "$OUT" -t 8

# create a summary
multiqc "$OUT" -o "$OUT/multiqc_raw"