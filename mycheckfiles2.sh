#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo
echo "#==========================================================="
echo "Start Times"

rplpl=$(ls -t rplpl-slurm*.out | head -n 1)
rplspl=$(ls -t rplspl-slurm*.out | head -n 1)

head -n 1 "$rplpl" "$rplspl"

echo "End Times"

tail -n 5 "$rplpl" "$rplspl"

echo "#==========================================================="
