#!/bin/bash

# ---------------------------
# This script watches over modifications on 'ansible' directory then copies it to remote ansible controller
# ---------------------------

MONITORING_DIR=".."

declare COPY_DIRS=("ansible" "kubernetes");

function sync_files(){
  echo -n -e "\033]0;Syncing..\007"
  sleep 0.3

  . ./read-env-vars.sh && readEnvs #Update env vars

  for DIR in "${COPY_DIRS[@]}"; do
      rsync -av -e "ssh -o StrictHostKeyChecking=no" --delete "../$DIR" ansible@$ansiblecontroller:"/home/ansible/" || true
  done
  echo "finished."
}

clear

echo "===== INITIAL SYNC"
#create_remote_dirs
sync_files
echo "===== START MONITORING"
echo -n -e "\033]0;Waiting:\007"
fswatch -e ".~" $MONITORING_DIR | while read -r changed; do
    echo " -- Detected changes: $changed"
    sync_files
    echo -n -e "\033]0;Waiting:\007"
done