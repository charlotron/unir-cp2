SOURCE="/Users/carlos.cenjor/workspace/devops/repos/cp2/ansible/*"
TARGET="ansible@192.168.1.110:/home/ansible/ansible/"

#rsync -avP --delete $SOURCE $TARGET

#while fswatch -1 $SOURCE ; do
#  sleep 1
#  xargs -n1 rsync -av $SOURCE $TARGET
#done
echo "===== START MONITORING"
fswatch -e ".~" $SOURCE | while read -r changed; \
    do \
        echo " -- Detected changes: $changed"
        sleep 0.3
        rsync -av $SOURCE $TARGET || true
    done