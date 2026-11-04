
# ============================================================
# Install bioinformatics quality control tools FastQC
# ============================================================

# 1. Create Conda environment
# ------------------------------------------------------------
# Install FastQC, MultiQC, fastp, Bowtie2, SAMtools, and SeqKit.

conda create -y \
    -p /athena/linglab/scratch/yil4013/ICI/envs/qc \
    -c conda-forge \
    -c bioconda \
    fastqc multiqc fastp bowtie2 samtools seqkit


# 2. Activate environment
# ------------------------------------------------------------

conda activate /athena/linglab/scratch/username/projectA/envs/qc


# 3. Verify installation
# ------------------------------------------------------------

echo "Checking installed software versions..."

fastqc --version
multiqc --version
fastp --version
bowtie2 --version
samtools --version
seqkit version

echo "All installation checks completed."


# 4. Deactivate environment when finished
# ------------------------------------------------------------
# Run the following command manually when you are done:
conda deactivate
