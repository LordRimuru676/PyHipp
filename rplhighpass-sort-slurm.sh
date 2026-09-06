#!/bin/bash

# Submit this script with: sbatch <this-filename>

#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH -J "rplhps"

#SBATCH -o rplhps-slurm.%N.%j.out
#SBATCH -e rplhps-slurm.%N.%j.err

# Initialise conda
/data/miniconda3/bin/conda init
source ~/.bashrc

# Get an available cloned environment
envarg=`/data/src/PyHipp/envlist.py`

# Activate the selected environment
conda activate $envarg

# Run high-pass filtering and MountainSort
python -u -c "import PyHipp as pyh; \
import time; \
pyh.RPLHighPass(saveLevel=1); \
from PyHipp import mountain_batch; \
mountain_batch.mountain_batch(); \
from PyHipp import export_mountain_cells; \
export_mountain_cells.export_mountain_cells(); \
print(time.localtime());"

# Deactivate the cloned environment
conda deactivate

# Return the environment to the available pool
/data/src/PyHipp/envlist.py $envarg
