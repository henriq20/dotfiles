#!/bin/bash

# ------------------------------------------------------------------------------
# Checks the disk usage assyncronously in order to not block the user interface
# ------------------------------------------------------------------------------

tmp=$(mktemp -td)
mkfifo "$tmp/f"
trap 'rm -rf "$tmp"' EXIT

get_disk_usage() {
    # echo $(df -h | grep "\/$" | awk '{ print $4 }') > "$tmp/get_disk_usage";
    echo 'abc' > "$tmp/f";
}

get_disk_usage &

# wait $!

disk_usage=$(< "$tmp/f")

echo $disk_usage

# fifo setup/clean-up
# tmp=$(mktemp -td)
# mkfifo "$tmp/f"
# trap 'rm -rf "$tmp"' EXIT

# # async f, push result to fifo
# f() { sleep 1; echo "result" >"$tmp/f"; }
# f &

# # work

# # block until f finishes, read result from fifo
# f_ret=$(<"$tmp/f")
# echo "f done, returned: $f_ret"
