SOURCE="/Users/carlos.cenjor/workspace/devops/repos/cp2/*"
TARGET="ansible@192.168.1.110:/home/ansible/"

function sync_files(){
  echo -n -e "\033]0;Syncing..\007"
  sleep 0.3
  rsync -av --delete $SOURCE $TARGET || true
}

clear
echo "===== INITIAL SYNC"
sync_files
echo "===== START MONITORING"
echo -n -e "\033]0;Waiting:\007"
fswatch -e ".~" $SOURCE | while read -r changed; \
    do \
        echo " -- Detected changes: $changed"
        sync_files
        echo -n -e "\033]0;Waiting:\007"
    done