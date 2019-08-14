#!/bin/bash
set -euo pipefail

CLOUD_INIT_OUTPUT_LOG=/var/log/cloud-init-output.log
CLOUD_INIT_BOOT_FINISHED=/var/lib/cloud/instance/boot-finished

if [ ! -f "$CLOUD_INIT_OUTPUT_LOG" ]; then
  echo "ERROR: Unable to watch cloud-init, ensure everything is correct"
  exit 1
fi

tail -f "$CLOUD_INIT_OUTPUT_LOG" &
time -p bash -c \
  "until [ -f $CLOUD_INIT_BOOT_FINISHED ]; do sleep 1; done"

echo "SUCCESS: cloud-init boot finished"
