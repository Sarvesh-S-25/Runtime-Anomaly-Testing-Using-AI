#!/bin/bash

LOGDIR=logs/day1
mkdir -p "$LOGDIR"

qemu-system-x86_64 \
  -kernel bzImage \
  -initrd initramfs.gz \
  -append "console=ttyS0 rdinit=/init" \
  -nographic \
  -monitor none \
  -serial mon:stdio \
  2>&1 | tee "$LOGDIR/serial.log"

