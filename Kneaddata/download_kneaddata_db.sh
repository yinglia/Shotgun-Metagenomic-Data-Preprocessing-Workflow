#!/bin/bash
#SBATCH --job-name=human_index
#SBATCH --partition=scu-cpu
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=/athena/linglab/scratch/yil4013/ICI/kd_db_%j.log

set -euo pipefail
# Load conda
source ~/yes/etc/profile.d/conda.sh
conda activate /athena/linglab/scratch/yil4013/ICI/envs/kneaddata

DB=/athena/linglab/scratch/yil4013/ICI/db/kneaddata_human
mkdir -p "$DB"
kneaddata_database --download human_genome bowtie2 "$DB"
