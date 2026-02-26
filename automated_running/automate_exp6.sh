#!/bin/sh

RUNS=500

for CPU in 1 2 4
do
  echo "===== STARTING EXP6 CPU=$CPU ====="
  mkdir -p logs/exp6/cpu$CPU

  i=1
  while [ $i -le $RUNS ]
  do
    RUN_ID=$(printf "%03d" $i)
    echo "Running EXP6 | CPU=$CPU | Run=$RUN_ID"

    ./run-qemu.sh -smp $CPU | tee logs/exp6/cpu$CPU/run_$RUN_ID.log

    i=$((i+1))
  done

  echo "===== DONE EXP6 CPU=$CPU ====="
done
