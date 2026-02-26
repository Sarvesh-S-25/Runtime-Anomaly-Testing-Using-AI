#!/bin/bash
set -e

EXP=exp4
RUNS=500

for CPU in 1 2 4; do
  mkdir -p logs/$EXP/cpu$CPU

  for i in $(seq -w 1 $RUNS); do
    echo "EXP4 | CPU=$CPU | RUN=$i"
    ./run-qemu.sh $CPU | tee logs/$EXP/cpu$CPU/run_${i}.log
  done
done
