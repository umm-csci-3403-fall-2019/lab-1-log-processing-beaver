#!/usr/bin/env bash
dir=$1
cd $dir
cat var/log/secure* | sed -E -n 's/(^[^:]+).+: Failed password for (invalid user )?([a-zA-Z0-9_-]*) from ([0-9.]*) port [0-9]* ssh2/\1 \3 \4/p' > failed_login_data.txt
