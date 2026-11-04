# Example Project Structure

The following directory structure illustrates how a shotgun metagenomic data preprocessing project can be organized on an HPC cluster.

```text
project/
├── scripts/
│   ├── download_wgs.sh
│   ├── run_fastqc.sh
│   ├── run_kneaddata.sh
│   ├── run_metaphlan.sh
│   └── run_metaphlan_with_reads.sh
│
├── rawdata/
│   └── wgs/
│
├── results/
│   ├── fastqc_out/
│   ├── kneaddata_out/
│   ├── metaphlan_out/
│   └── metaphlan_with_reads_out/
│
├── logs/
│
└── envs/
    ├── qc/
    ├── kneaddata/
    └── metaphlan4/
