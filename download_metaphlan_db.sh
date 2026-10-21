#!/bin/bash
#SBATCH --job-name=metaphlan_db_download
#SBATCH --partition=scu-cpu
#SBATCH --mem=16G
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=4
#SBATCH --output=projectA/metaphlan_db_download_%j.out
#SBATCH --error=projectA/metaphlan_db_download_%j.err

# ---- Setup ----
echo "Job started on $(hostname) at $(date)"

# Load conda
source ~/yes/etc/profile.d/conda.sh
# (confirmed: `which conda` -> ~/yes/condabin/conda, so base install dir is ~/yes)

# Activate the metaphlan environment
conda activate projectA/envs/metaphlan4_pip

# Make sure the database directory exists
mkdir -p projectA/metaphlan_db

# ---- Download database ----
metaphlan --install --bowtie2db projectA/metaphlan_db

echo "Job finished at $(date)"
