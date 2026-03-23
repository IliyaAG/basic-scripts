script="${0##*/}"
lock_file="/tmp/.$script.lock"

cleanup() {
    rm -f $lock_file
    echo $script finished
}
exec 200> $lock_file
flock -n 200 || { echo ""$(date +"%F %T")" Script is already running. Exiting."; exit 1; }
#
#
trap cleanup EXIT
