#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "rplhps"

#SBATCH -o rplhps-slurm.%N.%j.out
#SBATCH -e rplhps-slurm.%N.%j.err

# Enable conda in this batch shell
source /data/miniconda3/etc/profile.d/conda.sh

# Borrow one cloned environment
envarg=$(/data/src/PyHipp/envlist.py)

echo "Using environment: $envarg"

# Activate borrowed environment
conda activate "$envarg"

python -u -c "import PyHipp as pyh; \
import time; \
pyh.RPLHighPass(saveLevel=1); \
from PyHipp import mountain_batch; \
mountain_batch.mountain_batch(); \
from PyHipp import export_mountain_cells; \
export_mountain_cells.export_mountain_cells(); \
print(time.localtime());"

# Leave cloned environment
conda deactivate

# Return environment to pool
/data/src/PyHipp/envlist.py "$envarg"
