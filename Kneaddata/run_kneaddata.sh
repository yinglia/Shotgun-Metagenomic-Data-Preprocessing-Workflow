#!/bin/bash
#SBATCH --job-name=kneaddata
#SBATCH --partition=scu-cpu
#SBATCH --cpus-per-task=8
#SBATCH --mem=48G
#SBATCH --time=48:00:00
#SBATCH --output=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/kneaddata_%j.log

set -euo pipefail
source ~/yes/etc/profile.d/conda.sh
conda activate /athena/linglab/scratch/yil4013/ICI/envs/kneaddata

IN=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/raw_data
OUT=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/kneaddata_out

DB=/athena/linglab/scratch/yil4013/ICI/db/kneaddata_human/hg_39

mkdir -p "$OUT"

for r1 in "$IN"/*_1.fastq.gz; do
  id=$(basename "$r1" _1.fastq.gz)
  r2="$IN/${id}_2.fastq.gz"
  [ -f "$r2" ] || { echo "Skipping $id: R2 missing"; continue; }
  [ -f "$OUT/${id}_paired_1.fastq" ] && { echo "Skipping $id: already done"; continue; }

  kneaddata \
    --input1 "$r1" --input2 "$r2" \
    --reference-db "$DB" \
    --output "$OUT" \
    --output-prefix "$id" \
    --threads 8 \
    --bypass-trf
done