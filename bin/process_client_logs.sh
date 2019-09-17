#!/usr/bin/env bash
#takes a directory and sets it as dir variable
dir=$1
#go into directory
cd "$dir" || exit
#cat combines the text and then uses sed to select only the relevant text parts. Then outputs to failed_login_data.txt.
cat var/log/secure* | sed -E -n 's/(^[^:]+).+: Failed password for (invalid user )?([a-zA-Z0-9_-]*) from ([0-9.]*) port [0-9]* ssh2/\1 \3 \4/p' > failed_login_data.txt
