#!/bin/bash

RUNS=500
CPUS=(1 2 4)

for i in $(seq -w 1 $RUNS); do
  echo "=============================="
  echo " EXP5 ITERATION $i"
  echo "=============================="

  for CPU in "${CPUS[@]}"; do
    echo "---- EXP5 | CPU ${CPU} | RUN ${i} ----"
    ./run-qemu.sh -smp ${CPU} | tee logs/exp5/cpu${CPU}/run_${i}.log
  done
done
