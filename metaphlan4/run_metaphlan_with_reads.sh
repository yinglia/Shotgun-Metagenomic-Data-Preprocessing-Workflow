#!/bin/bash
#SBATCH --job-name=metaphlan_run
#SBATCH --partition=scu-cpu
#SBATCH --mem=48G
#SBATCH --cpus-per-task=4
#SBATCH --time=12:00:00
#SBATCH --array=12-53
#SBATCH --output=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/logs/metaphlan_%A_%a.out
#SBATCH --error=/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/logs/metaphlan_%A_%a.err

echo "Job started on $(hostname) at $(date), array task ID: $SLURM_ARRAY_TASK_ID"

# ---- Activate conda environment ----
source ~/yes/etc/profile.d/conda.sh
conda activate /athena/linglab/scratch/yil4013/ICI/envs/metaphlan4_pip

# ---- Paths (EDIT if different) ----
RAW_DIR="/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/raw_data"
DB_DIR="/athena/linglab/scratch/yil4013/ICI/metaphlan_db"
OUT_DIR="/athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/metaphlan_results_with_reads"

mkdir -p "$OUT_DIR"
mkdir -p /athena/linglab/scratch/yil4013/ICI/PRJNA678737/WGS/logs

cd "$RAW_DIR" || { echo "Directory not found, exiting."; exit 1; }

# ---- Find the sample matching this array task's ID ----
# EDIT the pattern below to match your actual file naming (e.g. SRR*30_1.fastq.gz, sample30_1.fastq.gz, etc.)
r1=$(ls *"${SLURM_ARRAY_TASK_ID}"_1.fastq.gz 2>/dev/null | head -n 1)

if [[ -z "$r1" ]]; then
    echo "ERROR: no R1 file found for sample ID ${SLURM_ARRAY_TASK_ID}, exiting."
    exit 1
fi

sample=$(basename "$r1" _1.fastq.gz)
r2="${sample}_2.fastq.gz"

if [[ -f "$r2" ]]; then
    echo "Running MetaPhlAn on $sample ..."
    metaphlan "${r1},${r2}" \
        --input_type fastq \
        --db_dir "$DB_DIR" \
        --nproc "$SLURM_CPUS_PER_TASK" \
        --offline \
        -t rel_ab_w_read_stats \
        --mapout "${OUT_DIR}/${sample}.mapout.bz2" \
        -o "${OUT_DIR}/${sample}_profile_readstats.txt"
else
    echo "WARNING: missing pair for $sample (expected $r2), skipping."
fi

echo "Job finished at $(date)"
