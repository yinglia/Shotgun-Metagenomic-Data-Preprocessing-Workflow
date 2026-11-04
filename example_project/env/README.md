# Conda Environment Setup

Each tool or workflow component has its own Conda environment to manage software dependencies and avoid package conflicts.

Activate the required environment before running the corresponding workflow step:

conda activate /path/to/project/envs/qc
conda activate /path/to/project/envs/kneaddata
conda activate /path/to/project/envs/metaphlan4

Note: These are separate Conda environments. You only need to activate the environment required for the tool you are running.
