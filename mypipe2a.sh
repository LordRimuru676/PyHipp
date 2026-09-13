#!/bin/bash

# First job: create RPLParallel, Unity, EDFSplit objects
jid1=$(sbatch /data/src/PyHipp/rplparallel-slurm.sh)

# Process sessioneye first
jid2=$(sbatch /data/src/PyHipp/rse-slurm.sh)

# Only start the four session01 RPLSplit jobs after rse finishes successfully
jid3=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs1a-slurm.sh)
jid4=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs2a-slurm.sh)
jid5=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs3a-slurm.sh)
jid6=$(sbatch --dependency=afterok:${jid2##* } /data/src/PyHipp/rs4a-slurm.sh)

echo $jid1
echo $jid2
echo $jid3
echo $jid4
echo $jid5
echo $jid6
