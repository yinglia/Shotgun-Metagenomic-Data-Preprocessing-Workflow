#!/bin/bash
#SBATCH --job-name=fastqc_raw
#SBATCH --partition=scu-cpu
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=24:00:00
#SBATCH --output=/athena/linglab/scratch/yil4013/projectA/WGS/fastqc_%j.log

set -euo pipefail
source ~/yes/etc/profile.d/conda.sh
conda activate /athena/linglab/scratch/yil4013/projectA/envs/qc

IN=/athena/linglab/scratch/yil4013/ICI/projectA/WGS/raw_data
OUT=/athena/linglab/scratch/yil4013/ICI/projectA/WGS/qc_raw

mkdir -p "$OUT"

fastqc "$IN"/*.fastq.gz --outdir "$OUT" -t 8

# create a summary
multiqc "$OUT" -o "$OUT/multiqc_raw"
